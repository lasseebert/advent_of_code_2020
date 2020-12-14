defmodule Advent.Day14 do
  @moduledoc """
  Day 14
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    state = %{
      mem: %{},
      mask: nil
    }

    input
    |> parse()
    |> Enum.reduce(state, &step/2)
    |> Map.fetch!(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  defp step({:mask, mask}, state), do: %{state | mask: mask}
  defp step({:mem, {address, value}}, state), do: %{state | mem: Map.put(state.mem, address, mask(value, state.mask))}

  defp mask(value, {zero_mask, one_mask}) do
    value
    |> Bitwise.band(zero_mask)
    |> Bitwise.bor(one_mask)
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
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "mask = " <> mask_string -> {:mask, parse_mask(mask_string)}
      "mem" <> mem_string -> {:mem, parse_mem(mem_string)}
    end)
  end

  defp parse_mask(mask_string) do
    zero_mask = mask_string |> String.replace("X", "1") |> String.to_integer(2)
    one_mask = mask_string |> String.replace("X", "0") |> String.to_integer(2)
    {zero_mask, one_mask}
  end

  defp parse_mem(mem_string) do
    ~r/^\[(\d+)\] = (\d+)$/
    |> Regex.run(mem_string, capture: :all_but_first)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
