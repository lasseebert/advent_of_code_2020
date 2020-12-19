defmodule Advent.Day19 do
  @moduledoc """
  Day 19
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    data = parse(input)

    Enum.count(data.messages, &valid_string?(&1, data.grammar))
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    %{grammar: grammar, messages: messages} = parse(input)

    grammar =
      grammar
      |> Map.put(8, [[rule: 42], [rule: 42, rule: 8]])
      |> Map.put(11, [[rule: 42, rule: 31], [rule: 42, rule: 11, rule: 31]])

    Enum.count(messages, &valid_string?(&1, grammar))
  end

  defp valid_string?(string, grammar) do
    results = match_rule(0, string, grammar)
    {:ok, ""} in results
  end

  defp match_rule(num, string, grammar, indent \\ 0) do
    grammar
    |> Map.fetch!(num)
    |> Enum.flat_map(&match_expression(&1, string, grammar, indent + 1))
  end

  defp match_expression([{:literal, literal_char}], string, _grammar, _indent) do
    if String.starts_with?(string, literal_char) do
      [ok: String.slice(string, 1..-1)]
    else
      []
    end
  end

  defp match_expression([], string, _grammar, _indent), do: [{:ok, string}]

  defp match_expression([{:rule, rule_num} | rules], string, grammar, indent) do
    rule_num
    |> match_rule(string, grammar, indent)
    |> Enum.flat_map(fn {:ok, string} -> match_expression(rules, string, grammar, indent) end)
  end

  defp parse(input) do
    [grammar, messages] =
      input
      |> String.trim()
      |> String.split("\n\n")

    grammar =
      grammar
      |> String.split("\n", trim: true)
      |> Enum.into(%{}, fn line ->
        [rule_num, rules] = String.split(line, ": ")
        rule_num = String.to_integer(rule_num)

        rules =
          rules
          |> String.split(" | ")
          |> Enum.map(fn rule ->
            rule
            |> String.split(" ")
            |> Enum.map(fn
              ~s["a"] -> {:literal, "a"}
              ~s["b"] -> {:literal, "b"}
              rule_num -> {:rule, String.to_integer(rule_num)}
            end)
          end)

        {rule_num, rules}
      end)

    messages = messages |> String.split("\n", trim: true)

    %{
      grammar: grammar,
      messages: messages
    }
  end
end
