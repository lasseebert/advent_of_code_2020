defmodule Advent.Day22 do
  @moduledoc """
  Day 22
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> play()
    |> Enum.find(&(&1 != []))
    |> Enum.reverse()
    |> (&(&1 |> Enum.zip(1..length(&1)))).()
    |> Enum.map(fn {card, multiplier} -> card * multiplier end)
    |> Enum.sum()
  end

  defp play([[card_1 | deck_1], [card_2 | deck_2]]) do
    cond do
      card_1 > card_2 -> play([deck_1 ++ [card_1, card_2], deck_2])
      card_1 < card_2 -> play([deck_1, deck_2 ++ [card_2, card_1]])
    end
  end

  defp play([deck_1, deck_2]), do: [deck_1, deck_2]

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
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn player_section ->
      player_section
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
