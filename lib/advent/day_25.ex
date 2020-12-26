defmodule Advent.Day25 do
  @moduledoc """
  Day 25
  """

  @modulo 20_201_227

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    [public_1, public_2] = parse(input)
    secret_1 = find_secret(public_1)

    transform(public_2, secret_1)
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
  end

  defp find_secret(public) do
    1
    |> Stream.unfold(&{&1, rem(&1 * 7, @modulo)})
    |> Stream.with_index()
    |> Enum.find(fn {public_candidate, _index} -> public_candidate == public end)
    |> elem(1)
  end

  defp transform(public, secret) do
    1
    |> Stream.unfold(&{&1, rem(&1 * public, @modulo)})
    |> Enum.at(secret)
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
