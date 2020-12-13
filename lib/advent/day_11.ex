defmodule Advent.Day11 do
  @moduledoc """
  Day 11
  """

  @directions (for dx <- [-1, 0, 1],
                   dy <- [-1, 0, 1],
                   dx != 0 or dy != 0 do
                 {dx, dy}
               end)

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    seats = parse(input)
    neighbour_map = seats |> Map.keys() |> precalc_neighbours()

    seats
    |> step_until_no_change(neighbour_map, 4)
    |> Enum.count(fn {_pos, state} -> state == :occupied end)
  end

  defp precalc_neighbours(points) do
    points = MapSet.new(points)

    points
    |> Enum.into(%{}, fn point ->
      neighbours =
        @directions
        |> Enum.map(&add(point, &1))
        |> Enum.filter(&(&1 in points))

      {point, neighbours}
    end)
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    seats = parse(input)
    neighbour_map = seats |> Map.keys() |> precalc_distance_neighbours()

    seats
    |> step_until_no_change(neighbour_map, 5)
    |> Enum.count(fn {_pos, state} -> state == :occupied end)
  end

  defp precalc_distance_neighbours(points) do
    max_x = points |> Enum.map(&elem(&1, 0)) |> Enum.max()
    max_y = points |> Enum.map(&elem(&1, 1)) |> Enum.max()

    points = MapSet.new(points)

    points
    |> Enum.into(%{}, fn point ->
      neighbours =
        @directions
        |> Enum.flat_map(&distance_neighbour_for_point(points, point, &1, max_x, max_y))

      {point, neighbours}
    end)
  end

  def distance_neighbour_for_point(points, point, dir, max_x, max_y) do
    {x, y} = new_point = add(point, dir)

    cond do
      new_point in points -> [new_point]
      x > max_x or x < 0 or y > max_y or y < 0 -> []
      true -> distance_neighbour_for_point(points, new_point, dir, max_x, max_y)
    end
  end

  #
  # Common code for part 1 and 2 below here
  #

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, seats ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reject(fn {char, _index} -> char == "." end)
      |> Enum.reduce(seats, fn {_char, x}, seats -> Map.put(seats, {x, y}, :empty) end)
    end)
  end

  defp step_until_no_change(seats, neighbour_map, threshold) do
    recalc = seats |> Map.keys()
    step_until_no_change(seats, recalc, neighbour_map, threshold)
  end

  defp step_until_no_change(seats, recalc, neighbour_map, threshold) do
    {new_seats, recalc} = step(seats, recalc, neighbour_map, threshold)
    recalc = recalc |> List.flatten() |> Enum.uniq()

    if Enum.any?(recalc) do
      step_until_no_change(new_seats, recalc, neighbour_map, threshold)
    else
      seats
    end
  end

  defp step(seats, recalc, neighbour_map, threshold) do
    recalc
    |> Enum.reduce({seats, []}, fn pos, {new_seats, recalc} ->
      state = Map.fetch!(seats, pos)

      neighbours = Map.fetch!(neighbour_map, pos)

      count =
        neighbours
        |> Enum.map(&Map.fetch!(seats, &1))
        |> Enum.count(&(&1 == :occupied))

      case {state, count} do
        {:empty, 0} -> {Map.put(new_seats, pos, :occupied), [neighbours | recalc]}
        {:occupied, n} when n >= threshold -> {Map.put(new_seats, pos, :empty), [neighbours | recalc]}
        {_state, _n} -> {new_seats, recalc}
      end
    end)
  end

  defp add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}
end
