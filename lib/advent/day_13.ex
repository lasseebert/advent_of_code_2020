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
    %{bus_ids: bus_ids} = parse(input)

    bus_ids
    |> Enum.with_index()
    |> Enum.reject(fn {bus_id, _index} -> bus_id == :x end)
    |> Enum.map(fn {bus_id, index} ->
      # E.g. a bus with id 41 and index 7 will yield
      #   41 ≡ 34 (mod N)
      #   where N is the timestamp we're looking for
      # This is the same as "On the timestamp of the first bus, bus 41 departed 34 minutes ago (and will depart in 7)"
      # Now we just have to find the first N that satisfy all the bus lines
      remainder = rem(rem(bus_id - index, bus_id) + bus_id, bus_id)
      {bus_id, {remainder, bus_id}}
    end)
    |> Enum.reduce(&merge/2)
    |> (fn {_bus_id, {time, _inc}} -> time end).()
  end

  # Merge two bus lines into a single (new) bus line that is satisfied only when both the two inputs are
  defp merge({bus_id_1, {time_1, inc_1}}, {bus_id_2, {time_2, inc_2}}) do
    cond do
      # We're done searching. We found the first time where both bus lines depart
      # The new bus line will have id equal to least common multiple of the two and a modulo remainder equal to the
      # found time
      time_1 == time_2 ->
        merged_bus_id = lcm(bus_id_1, bus_id_2)
        {merged_bus_id, {time_1, merged_bus_id}}

      # Timestamp 1 is too low. Increment it so that it is at least timestamp 2 and repeat
      time_1 < time_2 ->
        diff = time_2 - time_1
        new_time = (div(diff - 1, inc_1) + 1) * inc_1 + time_1
        merge({bus_id_1, {new_time, inc_1}}, {bus_id_2, {time_2, inc_2}})

      # Timestamp 2 is too low. Increment it so that it is at least timestamp 1 and repeat
      time_1 > time_2 ->
        diff = time_1 - time_2
        new_time = (div(diff - 1, inc_2) + 1) * inc_2 + time_2
        merge({bus_id_1, {time_1, inc_1}}, {bus_id_2, {new_time, inc_2}})
    end
  end

  def lcm(a, b), do: div(abs(a * b), Integer.gcd(a, b))

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
