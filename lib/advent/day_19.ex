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

  defp valid_string?(string, grammar) do
    case match_rule(0, string, grammar) do
      {:ok, ""} -> true
      {:ok, _} -> false
      :error -> false
    end
  end

  defp match_rule(num, string, grammar) do
    grammar
    |> Map.fetch!(num)
    |> Enum.reduce_while(:error, fn expression, :error ->
      case match_expression(expression, string, grammar) do
        {:ok, rest} -> {:halt, {:ok, rest}}
        :error -> {:cont, :error}
      end
    end)
  end

  defp match_expression([{:literal, literal_char}], string, _grammar) do
    if String.starts_with?(string, literal_char) do
      {:ok, String.slice(string, 1..-1)}
    else
      :error
    end
  end

  defp match_expression(rules, string, grammar) do
    Enum.reduce_while(rules, {:ok, string}, fn {:rule, rule_num}, {:ok, string} ->
      case match_rule(rule_num, string, grammar) do
        {:ok, rest} -> {:cont, {:ok, rest}}
        :error -> {:halt, :error}
      end
    end)
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
