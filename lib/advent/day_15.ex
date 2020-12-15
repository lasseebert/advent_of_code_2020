defmodule Advent.Day15 do
  @moduledoc """
  Day 15
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> stream()
    |> Enum.at(2019)
  end

  @doc """
  Part 2
  Unoptimized. Runs in ~47 seconds on my machine
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> stream()
    |> Enum.at(29_999_999)
  end

  defp stream(starting_numbers) do
    Stream.unfold({nil, starting_numbers, 0, %{}}, fn {last, starting_numbers, index, seen} ->
      {num, starting_numbers} =
        case starting_numbers do
          [] ->
            case Map.fetch!(seen, last) do
              [_] -> {0, []}
              [a, b] -> {a - b, []}
            end

          [num | starting_numbers] ->
            {num, starting_numbers}
        end

      {num, {num, starting_numbers, index + 1, Map.update(seen, num, [index], fn [last | _] -> [index, last] end)}}
    end)
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
