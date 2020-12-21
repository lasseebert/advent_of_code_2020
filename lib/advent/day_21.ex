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

    allergen_to_foods =
      list
      |> Enum.flat_map(fn {food, allergens} -> Enum.map(allergens, &{&1, food}) end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    with_allergens =
      list
      |> Enum.flat_map(fn {food, allergens} ->
        Enum.filter(food, fn ingredient ->
          Enum.any?(allergens, fn allergen ->
            allergen_to_foods
            |> Map.fetch!(allergen)
            |> Enum.all?(&(ingredient in &1))
          end)
        end)
      end)
      |> Enum.uniq()

    ingredients_with_dups = Enum.flat_map(list, &elem(&1, 0))
    ingredients_without_allergens = Enum.uniq(ingredients_with_dups) -- with_allergens

    ingredients_without_allergens
    |> Enum.map(fn ingredient -> Enum.count(ingredients_with_dups, &(&1 == ingredient)) end)
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
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
