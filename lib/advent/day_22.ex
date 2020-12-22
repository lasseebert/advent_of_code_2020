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
    |> calc_score()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> play_recursive(MapSet.new())
    |> calc_score()
  end

  defp calc_score(decks) do
    [deck] = Enum.reject(decks, &(&1 == []))

    deck
    |> Enum.reverse()
    |> Enum.zip(1..length(deck))
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

  defp play_recursive([[card_1 | deck_1], [card_2 | deck_2]] = decks, states) do
    if decks in states do
      decks
    else
      new_states = MapSet.put(states, decks)

      cond do
        card_1 <= length(deck_1) and card_2 <= length(deck_2) ->
          case play_recursive([Enum.take(deck_1, card_1), Enum.take(deck_2, card_2)], MapSet.new()) do
            [[], _] -> :p2
            _ -> :p1
          end

        card_1 > card_2 ->
          :p1

        card_1 < card_2 ->
          :p2
      end
      |> case do
        :p1 -> play_recursive([deck_1 ++ [card_1, card_2], deck_2], new_states)
        :p2 -> play_recursive([deck_1, deck_2 ++ [card_2, card_1]], new_states)
      end
    end
  end

  defp play_recursive([deck_1, deck_2], _states), do: [deck_1, deck_2]

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
