defmodule Advent.Day11 do
  @moduledoc """
  --- Day 11: Seating System ---
  Your plane lands with plenty of time to spare. The final leg of your journey is a ferry that goes directly to the tropical island where you can finally start your vacation. As you reach the waiting area to board the ferry, you realize you're so early, nobody else has even arrived yet!

  By modeling the process people use to choose (or abandon) their seat in the waiting area, you're pretty sure you can predict the best place to sit. You make a quick map of the seat layout (your puzzle input).

  The seat layout fits neatly on a grid. Each position is either floor (.), an empty seat (L), or an occupied seat (#). For example, the initial seat layout might look like this:

  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  Now, you just need to model the people who will be arriving shortly. Fortunately, people are entirely predictable and always follow a simple set of rules. All decisions are based on the number of occupied seats adjacent to a given seat (one of the eight positions immediately up, down, left, right, or diagonal from the seat). The following rules are applied to every seat simultaneously:

  If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
  If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
  Otherwise, the seat's state does not change.
  Floor (.) never changes; seats don't move, and nobody sits on the floor.

  After one round of these rules, every seat in the example layout becomes occupied:

  #.##.##.##
  #######.##
  #.#.#..#..
  ####.##.##
  #.##.##.##
  #.#####.##
  ..#.#.....
  ##########
  #.######.#
  #.#####.##
  After a second round, the seats with four or more occupied adjacent seats become empty again:

  #.LL.L#.##
  #LLLLLL.L#
  L.L.L..L..
  #LLL.LL.L#
  #.LL.LL.LL
  #.LLLL#.##
  ..L.L.....
  #LLLLLLLL#
  #.LLLLLL.L
  #.#LLLL.##
  This process continues for three more rounds:

  #.##.L#.##
  #L###LL.L#
  L.#.#..#..
  #L##.##.L#
  #.##.LL.LL
  #.###L#.##
  ..#.#.....
  #L######L#
  #.LL###L.L
  #.#L###.##
  #.#L.L#.##
  #LLL#LL.L#
  L.L.L..#..
  #LLL.##.L#
  #.LL.LL.LL
  #.LL#L#.##
  ..L.L.....
  #L#LLLL#L#
  #.LLLLLL.L
  #.#L#L#.##
  #.#L.L#.##
  #LLL#LL.L#
  L.#.L..#..
  #L##.##.L#
  #.#L.LL.LL
  #.#L#L#.##
  ..L.L.....
  #L#L##L#L#
  #.LLLLLL.L
  #.#L#L#.##
  At this point, something interesting happens: the chaos stabilizes and further applications of these rules cause no seats to change state! Once people stop moving around, you count 37 occupied seats.

  Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> step_until_no_change()
    |> Enum.count(fn {_pos, state} -> state == :occupied end)
  end

  defp step_until_no_change(seats) do
    new_seats = step(seats)

    if new_seats == seats do
      seats
    else
      step_until_no_change(new_seats)
    end
  end

  defp step(seats) do
    seats
    |> Enum.into(%{}, fn {pos, state} ->
      new_state =
        case {state, count_occupied_neighbours(seats, pos)} do
          {:empty, 0} -> :occupied
          {:occupied, n} when n >= 4 -> :empty
          {state, _n} -> state
        end

      {pos, new_state}
    end)
  end

  defp count_occupied_neighbours(seats, pos) do
    pos
    |> neighbours()
    |> Enum.count(&(Map.get(seats, &1, :no_seat) == :occupied))
  end

  defp neighbours(pos) do
    for dx <- [-1, 0, 1],
        dy <- [-1, 0, 1],
        dx != 0 or dy != 0 do
      {dx, dy}
    end
    |> Enum.map(&add(pos, &1))
  end

  defp add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

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
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, seats ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reject(fn {char, _index} -> char == "." end)
      |> Enum.reduce(seats, fn {_char, x}, seats -> Map.put(seats, {x, y}, :empty) end)
    end)
  end
end
