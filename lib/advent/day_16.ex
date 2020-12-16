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
    valid_ranges = data.rules |> Map.values() |> List.flatten()

    data.tickets
    |> List.flatten()
    |> Enum.reject(fn value -> Enum.any?(valid_ranges, &(value in &1)) end)
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
  end

  defp parse(input) do
    [rules, [""], [_, own_ticket], [""], [_ | tickets]] =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.chunk_by(&(&1 == ""))

    own_ticket = parse_ticket(own_ticket)
    tickets = Enum.map(tickets, &parse_ticket/1)
    rules = Enum.into(rules, %{}, &parse_rule/1)

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
