defmodule Advent.Day24 do
  @moduledoc """
  Day 24
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.reduce(MapSet.new(), fn path, map ->
      tile = walk(path, {0, 0})
      if tile in map do
        MapSet.delete(map, tile)
      else
        MapSet.put(map, tile)
      end
    end)
    |> Enum.count()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
  end

  defp walk(path, pos) do
    Enum.reduce(path, pos, &step/2)
  end

  defp step(:e, {x, y}), do: {x + 1, y}
  defp step(:ne, {x, y}), do: {x, y + 1}
  defp step(:se, {x, y}), do: {x + 1, y - 1}
  defp step(:w, {x, y}), do: {x - 1, y}
  defp step(:nw, {x, y}), do: {x - 1, y + 1}
  defp step(:sw, {x, y}), do: {x, y - 1}

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> Stream.unfold(fn
        "" -> nil
        path -> parse_path(path)
      end)
      |> Enum.to_list()
    end)
  end

  defp parse_path("e" <> rest), do: {:e, rest}
  defp parse_path("ne" <> rest), do: {:ne, rest}
  defp parse_path("se" <> rest), do: {:se, rest}
  defp parse_path("w" <> rest), do: {:w, rest}
  defp parse_path("nw" <> rest), do: {:nw, rest}
  defp parse_path("sw" <> rest), do: {:sw, rest}
end
