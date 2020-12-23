defmodule Advent.Day23 do
  @moduledoc """
  Day 23
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Stream.iterate(&play_round/1)
    |> Enum.at(100)
    |> result()
  end

  defp play_round(cups) do
    [current | cups] = cups
    {selected, cups} = Enum.split(cups, 3)
    destination = find_destination(cups, current - 1)
    {split_1, [destination | split_2]} = Enum.split_while(cups, &(&1 != destination))
    split_1 ++ [destination] ++ selected ++ split_2 ++ [current]
  end

  defp find_destination(cups, 0), do: find_destination(cups, 9)

  defp find_destination(cups, target) do
    cups
    |> Enum.find(&(&1 == target))
    |> case do
      nil -> find_destination(cups, target - 1)
      destination -> destination
    end
  end

  defp result([1 | cups]), do: cups |> Enum.join() |> String.to_integer()
  defp result([first | cups]), do: result(cups ++ [first])

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
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end
end
