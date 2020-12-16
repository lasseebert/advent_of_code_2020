defmodule Advent.Day16 do
  @moduledoc """
  Day 16
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    data = parse(input)
    valid_ranges = data.rules |> Enum.flat_map(&elem(&1, 1))

    data.tickets
    |> List.flatten()
    |> Enum.reject(fn value -> Enum.any?(valid_ranges, &(value in &1)) end)
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: map
  def part_2(input) do
    data = parse(input)
    valid_ranges = data.rules |> Enum.flat_map(&elem(&1, 1))

    tickets =
      data.tickets
      |> Enum.reject(fn ticket ->
        Enum.any?(ticket, fn value ->
          Enum.all?(valid_ranges, &(not (value in &1)))
        end)
      end)

    tickets_data =
      [data.own_ticket | tickets]
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.with_index()

    matching_indexes = find_rules_index(data.rules, tickets_data, %{})

    data.own_ticket
    |> Enum.with_index()
    |> Enum.into(%{}, fn {value, index} -> {Map.fetch!(matching_indexes, index), value} end)
  end

  defp find_rules_index([], _tickets_data, acc), do: acc

  defp find_rules_index([{name, ranges} = rule | rules], tickets_data, acc) do
    tickets_data
    |> Enum.filter(fn {values, _index} ->
      Enum.all?(values, fn value ->
        Enum.any?(ranges, fn range -> value in range end)
      end)
    end)
    |> Enum.map(&elem(&1, 1))
    |> case do
      [index] ->
        tickets_data = tickets_data |> Enum.reject(fn {_values, value_index} -> value_index == index end)
        acc = Map.put(acc, index, name)
        find_rules_index(rules, tickets_data, acc)

      [_, _ | _] ->
        # Put last in queue and wait for a unique match
        rules = rules ++ [rule]
        find_rules_index(rules, tickets_data, acc)
    end
  end

  defp parse(input) do
    [rules, [""], [_, own_ticket], [""], [_ | tickets]] =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.chunk_by(&(&1 == ""))

    own_ticket = parse_ticket(own_ticket)
    tickets = Enum.map(tickets, &parse_ticket/1)
    rules = Enum.map(rules, &parse_rule/1)

    %{
      rules: rules,
      own_ticket: own_ticket,
      tickets: tickets
    }
  end

  defp parse_ticket(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_rule(line) do
    [name, ranges] = String.split(line, ": ")

    ranges =
      ranges
      |> String.split(" or ")
      |> Enum.map(fn range ->
        [a, b] = range |> String.split("-") |> Enum.map(&String.to_integer/1)
        a..b
      end)

    {name, ranges}
  end
end
