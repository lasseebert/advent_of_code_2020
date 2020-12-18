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
    |> Enum.map(fn tokens ->
      tokens
      |> build_expression()
      |> evaluate()
    end)
    |> Enum.sum()
  end

  defp build_expression(tokens) do
    {postfix, ops} = Enum.reduce(tokens, {[], []}, &build_postfix(&1, &2))

    (Enum.reverse(postfix) ++ ops)
    |> build_tree([])
  end

  defp build_postfix(:+, {output, [:* | op_stack]}), do: build_postfix(:+, {[:* | output], op_stack})
  defp build_postfix(:+, {output, op_stack}), do: {output, [:+ | op_stack]}
  defp build_postfix(:*, {output, [:+ | op_stack]}), do: build_postfix(:*, {[:+ | output], op_stack})
  defp build_postfix(:*, {output, op_stack}), do: {output, [:* | op_stack]}
  defp build_postfix({:int, num}, {output, op_stack}), do: {[{:int, num} | output], op_stack}
  defp build_postfix(:left_paren, {output, op_stack}), do: {output, [:left_paren | op_stack]}
  defp build_postfix(:right_paren, {output, op_stack}), do: pop_to_left_paren(output, op_stack)

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.map(fn tokens ->
      tokens
      |> build_expression_v2()
      |> evaluate()
    end)
    |> Enum.sum()
  end

  defp build_expression_v2(tokens) do
    {postfix, ops} = Enum.reduce(tokens, {[], []}, &build_postfix_v2(&1, &2))

    (Enum.reverse(postfix) ++ ops)
    |> build_tree([])
  end

  defp build_postfix_v2(:+, {output, op_stack}), do: {output, [:+ | op_stack]}
  defp build_postfix_v2(:*, {output, [:+ | op_stack]}), do: build_postfix_v2(:*, {[:+ | output], op_stack})
  defp build_postfix_v2(:*, {output, op_stack}), do: {output, [:* | op_stack]}
  defp build_postfix_v2({:int, num}, {output, op_stack}), do: {[{:int, num} | output], op_stack}
  defp build_postfix_v2(:left_paren, {output, op_stack}), do: {output, [:left_paren | op_stack]}
  defp build_postfix_v2(:right_paren, {output, op_stack}), do: pop_to_left_paren(output, op_stack)

  defp pop_to_left_paren(output, [:left_paren | op_stack]), do: {output, op_stack}
  defp pop_to_left_paren(output, [op | op_stack]), do: pop_to_left_paren([op | output], op_stack)

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&tokenize/1)
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
      num -> {:int, String.to_integer(num)}
    end)
  end

  defp evaluate({:+, a, b}), do: evaluate(a) + evaluate(b)
  defp evaluate({:*, a, b}), do: evaluate(a) * evaluate(b)
  defp evaluate({:int, num}), do: num

  # Convert postfix list to expression tree
  defp build_tree([], [expr]), do: expr
  defp build_tree([:+ | tokens], [a, b | stack]), do: build_tree(tokens, [{:+, a, b} | stack])
  defp build_tree([:* | tokens], [a, b | stack]), do: build_tree(tokens, [{:*, a, b} | stack])
  defp build_tree([{:int, num} | tokens], stack), do: build_tree(tokens, [{:int, num} | stack])

end
