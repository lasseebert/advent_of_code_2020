defmodule Advent.Day17 do
  @moduledoc """
  Day 17
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    solve(input, fn {x, y} -> {x, y, 0} end)
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    solve(input, fn {x, y} -> {x, y, 0, 0} end)
  end

  defp solve(input, dimension_mapper) do
    input
    |> parse(dimension_mapper)
    |> Stream.iterate(&step/1)
    |> Enum.at(6)
    |> Enum.count()
  end

  defp step(map) do
    map
    |> Enum.flat_map(&neighbours(&1))
    |> Enum.uniq()
    |> Enum.filter(fn node ->
      case {node in map, num_active_neighbours(node, map)} do
        {true, n} when n in [2, 3] -> true
        {false, 3} -> true
        _ -> false
      end
    end)
    |> MapSet.new()
  end

  defp neighbours({x, y, z}) do
    for xn <- [x - 1, x, x + 1],
        yn <- [y - 1, y, y + 1],
        zn <- [z - 1, z, z + 1],
        {xn, yn, zn} != {x, y, z} do
      {xn, yn, zn}
    end
  end

  defp neighbours({x, y, z, w}) do
    for xn <- [x - 1, x, x + 1],
        yn <- [y - 1, y, y + 1],
        zn <- [z - 1, z, z + 1],
        wn <- [w - 1, w, w + 1],
        {xn, yn, zn, wn} != {x, y, z, w} do
      {xn, yn, zn, wn}
    end
  end

  defp num_active_neighbours(node, map) do
    node
    |> neighbours()
    |> Enum.count(&(&1 in map))
  end

  defp parse(input, dimension_mapper) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, y}, map ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) == "#"))
      |> Enum.reduce(map, fn {_char, x}, map ->
        node = dimension_mapper.({x, y})
        MapSet.put(map, node)
      end)
    end)
  end
end
