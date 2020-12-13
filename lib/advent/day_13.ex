defmodule Advent.Day13 do
  @moduledoc """
  Day 13
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    %{depart_time: depart_time, bus_ids: bus_ids} = parse(input)

    bus_ids
    |> Enum.reject(&(&1 == :x))
    |> Enum.map(fn bus_id ->
      minutes_late = rem(depart_time, bus_id)
      wait_time = rem(bus_id - minutes_late, bus_id)
      {bus_id, wait_time}
    end)
    |> Enum.min_by(&elem(&1, 1))
    |> (fn {bus_id, wait_time} -> bus_id * wait_time end).()
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
    [depart_time, bus_ids] =
      input
      |> String.trim()
      |> String.split("\n", trim: true)

    depart_time = String.to_integer(depart_time)

    bus_ids =
      bus_ids
      |> String.split(",")
      |> Enum.map(fn
        "x" -> :x
        id -> String.to_integer(id)
      end)

    %{
      depart_time: depart_time,
      bus_ids: bus_ids
    }
  end
end
