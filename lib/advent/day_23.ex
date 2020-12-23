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

  defp result_1(cups) do
    {first, cups} = pop_front(cups)

    cups
    |> push_rear(first)
    |> result_1()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: String.t()
  def part_2(input) do
    (parse(input) ++ Enum.to_list(10..1_000_000))
    |> play()
    |> Enum.at(10_000_000)
    |> result_2()
  end

  defp play(cups) do
    max = Enum.max(cups)
    zipper = {[], cups}

    Stream.iterate(zipper, &play_round(&1, max))
  end

  defp result_2({_, [1 | _]} = cups) do
    {1, cups} = pop_front(cups)
    {a, cups} = pop_front(cups)
    {b, _cups} = pop_front(cups)
    [a, b] |> Enum.join()
  end

  defp result_2(cups) do
    IO.inspect(cups, label: "cups in result_2")
    {front, cups} = pop_front(cups)

    cups
    |> push_rear(front)
    |> result_2()
  end

  defp play_round(cups, max) do
    {current, cups} = pop_front(cups)

    {a, cups} = pop_front(cups)
    {b, cups} = pop_front(cups)
    {c, cups} = pop_front(cups)
    selected = [a, b, c]

    destination = find_destination(current - 1, selected, max)
    cups = insert_after(cups, destination, selected)
    cups = push_rear(cups, current)
    cups

    # [current | cups] = cups
    # {selected, cups} = Enum.split(cups, 3)
    # destination = find_destination(cups, current - 1)
    # {split_1, [destination | split_2]} = Enum.split_while(cups, &(&1 != destination))
    # split_1 ++ [destination] ++ selected ++ split_2 ++ [current]
  end

  defp find_destination(0, selected, max), do: find_destination(max, selected, max)

  defp find_destination(target, selected, max) do
    if target in selected do
      find_destination(target - 1, selected -- [target], max)
    else
      target
    end
  end

  defp pop_front({l1, [front | l2]}), do: {front, {l1, l2}}
  defp pop_front({l1, []}), do: pop_front({[], Enum.reverse(l1)})

  defp push_rear({l1, l2}, item), do: {[item | l1], l2}

  defp insert_after({l1, l2}, destination, items) do
    case insert_after_front(l2, destination, items, []) do
      {:ok, l2} ->
        {l1, l2}

      :error ->
        l1 = insert_after_rear(l1, destination, items, [])
        {l1, l2}
    end
  end

  defp insert_after_front([], _destination, _items, _acc), do: :error

  defp insert_after_front([destination | list], destination, items, acc) do
    list = [destination | items] ++ list
    {:ok, Enum.reverse(acc) ++ list}
  end

  defp insert_after_front([first | list], destination, items, acc) do
    insert_after_front(list, destination, items, [first | acc])
  end

  defp insert_after_rear([destination | list], destination, items, acc) do
    list = Enum.reverse([destination | items]) ++ list
    Enum.reverse(acc) ++ list
  end

  defp insert_after_rear([first | list], destination, items, acc) do
    insert_after_rear(list, destination, items, [first | acc])
  end

  defp parse(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end
end
