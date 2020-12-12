defmodule Advent.Day12 do
  @moduledoc """
  Day 12
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.reduce({{0, 0}, {1, 0}}, &step/2)
    |> elem(0)
    |> manhattan_distance_to_origin()
  end

  defp step({:north, value}, {{x, y}, dir}), do: {{x, y + value}, dir}
  defp step({:south, value}, {{x, y}, dir}), do: {{x, y - value}, dir}
  defp step({:east, value}, {{x, y}, dir}), do: {{x + value, y}, dir}
  defp step({:west, value}, {{x, y}, dir}), do: {{x - value, y}, dir}

  defp step({:forward, value}, {{x, y}, {dx, dy}}), do: {{x + dx * value, y + dy * value}, {dx, dy}}

  defp step({:left, value}, state), do: step({:right, 360 - value}, state)
  defp step({:right, 0}, state), do: state
  defp step({:right, 90}, {pos, {dx, dy}}), do: {pos, {dy, dx * -1}}

  defp step({:right, value}, state) when value > 90 do
    state = step({:right, 90}, state)
    step({:right, value - 90}, state)
  end

  defp manhattan_distance_to_origin({x, y}), do: abs(x) + abs(y)

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.reduce({{0, 0}, {10, 1}}, &step_waypoint/2)
    |> elem(0)
    |> manhattan_distance_to_origin()
  end

  defp step_waypoint({:north, value}, {pos, {wx, wy}}), do: {pos, {wx, wy + value}}
  defp step_waypoint({:south, value}, {pos, {wx, wy}}), do: {pos, {wx, wy - value}}
  defp step_waypoint({:east, value}, {pos, {wx, wy}}), do: {pos, {wx + value, wy}}
  defp step_waypoint({:west, value}, {pos, {wx, wy}}), do: {pos, {wx - value, wy}}

  defp step_waypoint({:forward, value}, {{x, y}, {wx, wy}}), do: {{x + wx * value, y + wy * value}, {wx, wy}}

  defp step_waypoint({:left, value}, state), do: step_waypoint({:right, 360 - value}, state)
  defp step_waypoint({:right, 0}, state), do: state
  defp step_waypoint({:right, 90}, {{x, y}, {wx, wy}}), do: {{x, y}, {wy, wx * -1}}

  defp step_waypoint({:right, value}, state) when value > 90 do
    state = step_waypoint({:right, 90}, state)
    step_waypoint({:right, value - 90}, state)
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {op, value} = String.split_at(line, 1)
      {parse_op(op), String.to_integer(value)}
    end)
  end

  defp parse_op("N"), do: :north
  defp parse_op("S"), do: :south
  defp parse_op("E"), do: :east
  defp parse_op("W"), do: :west
  defp parse_op("F"), do: :forward
  defp parse_op("R"), do: :right
  defp parse_op("L"), do: :left
end
