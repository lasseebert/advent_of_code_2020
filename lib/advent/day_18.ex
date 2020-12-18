defmodule Advent.Day18 do
  @moduledoc """
  Day 18
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.map(&evaluate/1)
    |> Enum.sum()
  end

  defp evaluate({:+, a, b}), do: evaluate(a) + evaluate(b)
  defp evaluate({:*, a, b}), do: evaluate(a) * evaluate(b)
  defp evaluate(num) when is_integer(num), do: num

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
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {expr, []} =
        line
        |> tokenize()
        |> build_expression(nil, nil)

      expr
    end)
  end

  defp tokenize(expression) do
    expression
    |> String.split(~r/\b| |(?=[\(\)])/)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn
      "(" -> :left_paren
      ")" -> :right_paren
      "+" -> :+
      "*" -> :*
      num -> String.to_integer(num)
    end)
  end

  # Done state, return expression (and no leftover tokens)
  defp build_expression([], expr, nil), do: {expr, []}

  # We already have an expression and now got an operator
  defp build_expression([op | tokens], expr, nil) when op in [:+, :*], do: build_expression(tokens, expr, op)

  # Start a new call stack on left_parent. This call stack will end on right paren
  defp build_expression([:left_paren | tokens], expr, op) do
    {inner_expr, tokens} = build_expression(tokens, nil, nil)
    build_expression([inner_expr | tokens], expr, op)
  end

  # End inner call stack and also return leftover tokens
  defp build_expression([:right_paren | tokens], expr, nil), do: {expr, tokens}

  # We have to expressions and an operator. Combine them into one expression
  defp build_expression([expr_1 | tokens], expr_2, op) when op in [:+, :*],
    do: build_expression([{op, expr_2, expr_1} | tokens], nil, nil)

  # We have a single expression, just put it on the stack
  defp build_expression([expr | tokens], nil, nil), do: build_expression(tokens, expr, nil)
end
