defmodule Advent.Day23 do
  @moduledoc """
  Day 23
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: String.t()
  def part_1(input) do
    input
    |> parse()
    |> play()
    |> Enum.at(100)
    |> result_1()
  end

  defp result_1({l1, [1 | l2]}) do
    (l2 ++ Enum.reverse(l1))
    |> Enum.join()
  end

  defp result_1({cups, _current}) do
    {cups, 1}
    |> Stream.unfold(fn {cups, current} ->
      case Map.fetch!(cups, current) do
        1 -> nil
        n -> {n, {cups, n}}
      end
    end)
    |> Enum.join()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    (parse(input) ++ Enum.to_list(10..1_000_000))
    |> play()
    |> Enum.at(10_000_000)
    |> result_2()
  end

  defp result_2({cups, _current}) do
    a = Map.fetch!(cups, 1)
    b = Map.fetch!(cups, a)
    a * b
  end

  defp play(cups) do
    max = Enum.max(cups)
    [current | _] = cups

    linked_list_map =
      cups
      |> Enum.chunk_every(2, 1, [current])
      |> Enum.into(%{}, fn [node, link] -> {node, link} end)

    Stream.iterate({linked_list_map, current}, &play_round(&1, max))
  end

  defp play_round({cups, current}, max) do
    a = Map.fetch!(cups, current)
    b = Map.fetch!(cups, a)
    c = Map.fetch!(cups, b)
    after_selection = Map.fetch!(cups, c)

    destination = find_destination(current - 1, [a, b, c], max)
    after_destination = Map.fetch!(cups, destination)

    cups =
      cups
      |> Map.put(current, after_selection)
      |> Map.put(destination, a)
      |> Map.put(c, after_destination)

    {cups, after_selection}
  end

  defp find_destination(0, selected, max), do: find_destination(max, selected, max)

  defp find_destination(target, selected, max) do
    if target in selected do
      find_destination(target - 1, selected, max)
    else
      target
    end
  end

  defp parse(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end
end
