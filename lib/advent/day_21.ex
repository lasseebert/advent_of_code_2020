defmodule Advent.Day21 do
  @moduledoc """
  Day 21
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    list = parse(input)
    safe = safe_ingredients(list)

    ingredients_with_dups = Enum.flat_map(list, &elem(&1, 0))

    safe
    |> Enum.map(fn ingredient -> Enum.count(ingredients_with_dups, &(&1 == ingredient)) end)
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    list = parse(input)
    safe = safe_ingredients(list)

    list =
      Enum.map(list, fn {food, allergen} ->
        {food -- safe, allergen}
      end)

    all_ingredients = list |> Enum.flat_map(&elem(&1, 0)) |> Enum.uniq()
    all_allergens = list |> Enum.flat_map(&elem(&1, 1)) |> Enum.uniq()

    true = length(all_ingredients) == length(all_allergens)

    candidates =
      Enum.reduce(list, %{}, fn {food, allergens}, candidates ->
        Enum.reduce(food, candidates, fn ingredient, candidates ->
          Enum.reduce(allergens, candidates, fn allergen, candidates ->
            Map.update(candidates, ingredient, MapSet.new([allergen]), &MapSet.put(&1, allergen))
          end)
        end)
      end)

    [mapping] = match(all_ingredients, all_allergens, %{}, list, candidates)

    mapping
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.join(",")
  end

  defp safe_ingredients(food_list) do
    allergen_to_foods =
      food_list
      |> Enum.flat_map(fn {food, allergens} -> Enum.map(allergens, &{&1, food}) end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    with_allergens =
      food_list
      |> Enum.flat_map(fn {food, allergens} ->
        Enum.filter(food, fn ingredient ->
          Enum.any?(allergens, fn allergen ->
            allergen_to_foods |> Map.fetch!(allergen) |> Enum.all?(&(ingredient in &1))
          end)
        end)
      end)
      |> Enum.uniq()

    ingredients = food_list |> Enum.flat_map(&elem(&1, 0)) |> Enum.uniq()
    ingredients -- with_allergens
  end

  defp match([], [], acc, list, _candidates) do
    list
    |> Enum.all?(fn {food, allergens} ->
      mapped_food = Enum.map(food, &Map.fetch!(acc, &1))
      Enum.all?(allergens, &(&1 in mapped_food))
    end)
    |> case do
      true -> [acc]
      false -> []
    end
  end

  defp match([ingredient | ingredients], allergens, acc, list, candidates) do
    candidates
    |> Map.fetch!(ingredient)
    |> Enum.filter(&(&1 in allergens))
    |> Enum.flat_map(fn allergen ->
      allergens = allergens -- [allergen]
      acc = Map.put(acc, ingredient, allergen)
      match(ingredients, allergens, acc, list, candidates)
    end)
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [food, allergens] = Regex.run(~r/^(.*) \(contains (.*)\)$/, line, capture: :all_but_first)
      food = String.split(food, " ")
      allergens = String.split(allergens, ", ")
      {food, allergens}
    end)
  end
end
