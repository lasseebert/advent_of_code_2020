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
    |> Enum.reduce(state, &step_v1/2)
    |> Map.fetch!(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  defp step_v1({:mask, mask}, state), do: %{state | mask: parse_mask_v1(mask)}

  defp step_v1({:mem, {address, value}}, state) do
    %{
      state
      | mem: Map.put(state.mem, address, apply_mask_v1(value, state.mask))
    }
  end

  defp parse_mask_v1(mask_string) do
    zero_mask = mask_string |> String.replace("X", "1") |> String.to_integer(2)
    one_mask = mask_string |> String.replace("X", "0") |> String.to_integer(2)
    {zero_mask, one_mask}
  end

  defp apply_mask_v1(value, {zero_mask, one_mask}) do
    value
    |> Bitwise.band(zero_mask)
    |> Bitwise.bor(one_mask)
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    state = %{
      mem: %{},
      mask: nil
    }

    input
    |> parse()
    |> Enum.reduce(state, &step_v2/2)
    |> Map.fetch!(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  defp step_v2({:mask, mask}, state), do: %{state | mask: parse_mask_v2(mask)}

  defp step_v2({:mem, {address, value}}, state) do
    mem =
      address
      |> apply_mask_v2(state.mask)
      |> Enum.reduce(state.mem, &Map.put(&2, &1, value))

    %{state | mem: mem}
  end

  defp parse_mask_v2(mask_string) do
    mask_string
    |> String.graphemes()
    |> Enum.map(fn
      "0" -> 0
      "1" -> 1
      "X" -> :x
    end)
  end

  defp apply_mask_v2(address, mask) do
    address
    |> Integer.to_string(2)
    |> String.pad_leading(36, "0")
    |> String.graphemes()
    |> Enum.zip(mask)
    |> Enum.map(fn
      {"0", 0} -> 0
      {"1", 0} -> 1
      {_num, 1} -> 1
      {_num, :x} -> :x
    end)
    |> Enum.reverse()
    |> expand_floating(1)
  end

  defp expand_floating([], _exp), do: [0]

  defp expand_floating([digit | digits], exp) do
    tail = digits |> expand_floating(Bitwise.<<<(exp, 1))

    if digit == :x do
      Enum.flat_map(tail, &[&1, &1 + exp])
    else
      Enum.map(tail, &(&1 + exp * digit))
    end
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "mask = " <> mask_string -> {:mask, mask_string}
      "mem" <> mem_string -> {:mem, parse_mem(mem_string)}
    end)
  end

  defp parse_mem(mem_string) do
    ~r/^\[(\d+)\] = (\d+)$/
    |> Regex.run(mem_string, capture: :all_but_first)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
