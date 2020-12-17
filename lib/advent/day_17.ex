defmodule Advent.Day17 do
  @moduledoc """
  Day 17
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.map(fn {x, y} -> {x, y, 0} end)
    |> step_count(6)
    |> Enum.count()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.map(fn {x, y} -> {x, y, 0, 0} end)
    |> step_count(6)
    |> Enum.count()
  end

  defp step_count(map, 0), do: map
  defp step_count(map, count), do: map |> step() |> step_count(count - 1)

  defp step(map) do
    existing_nodes =
      map
      |> Enum.flat_map(fn node ->
        case num_active_neighbours(node, map) do
          n when n in [2, 3] -> [node]
          _ -> []
        end
      end)

    new_nodes =
      map
      |> Enum.flat_map(&neighbours(&1))
      |> Enum.uniq()
      |> Enum.reject(&(&1 in map))
      |> Enum.flat_map(fn node ->
        case num_active_neighbours(node, map) do
          3 -> [node]
          _ -> []
        end
      end)

    [existing_nodes, new_nodes]
    |> Stream.concat()
    |> Enum.to_list()
    |> Enum.reduce(MapSet.new(), &MapSet.put(&2, &1))
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

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, y}, map ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) == "#"))
      |> Enum.reduce(map, fn {_char, x}, map -> MapSet.put(map, {x, y}) end)
    end)
  end
end
