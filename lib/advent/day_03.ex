defmodule Advent.Day03 do
  @moduledoc """
  --- Day 3: Toboggan Trajectory ---
  With the toboggan login problems resolved, you set off toward the airport. While travel by toboggan might be easy, it's certainly not safe: there's very minimal steering and the area is covered in trees. You'll need to see which angles will take you near the fewest trees.

  Due to the local geology, trees in this area only grow on exact integer coordinates in a grid. You make a map (your puzzle input) of the open squares (.) and trees (#) you can see. For example:

  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  These aren't the only trees, though; due to something you read about once involving arboreal genetics and biome stability, the same pattern repeats to the right many times:

  ..##.........##.........##.........##.........##.........##.......  --->
  #...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
  .#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
  ..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
  .#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
  ..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....  --->
  .#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
  .#........#.#........#.#........#.#........#.#........#.#........#
  #.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
  #...##....##...##....##...##....##...##....##...##....##...##....#
  .#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
  You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).

  The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:

  From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.

  The locations you'd check in the above example are marked here with O where there was an open square and X where there was a tree:

  ..##.........##.........##.........##.........##.........##.......  --->
  #..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
  .#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
  ..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
  .#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
  ..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##.....  --->
  .#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
  .#........#.#........X.#........#.#........#.#........#.#........#
  #.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#...
  #...##....##...##....##...#X....##...##....##...##....##...##....#
  .#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
  In this example, traversing the map using this slope would cause you to encounter 7 trees.

  Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?

  --- Part Two ---
  Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.

  Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

  Right 1, down 1.
  Right 3, down 1. (This is the slope you already checked.)
  Right 5, down 1.
  Right 7, down 1.
  Right 1, down 2.
  In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.
  """

  @doc """
  Part 1
  """
  @spec count_trees(String.t()) :: non_neg_integer
  def count_trees(input) do
    map = parse(input)
    do_count_trees(map, {3, 1})
  end

  @doc """
  Part 2
  """
  @spec count_trees_multi(String.t()) :: non_neg_integer
  def count_trees_multi(input) do
    map = parse(input)

    [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]
    |> Enum.map(&do_count_trees(map, &1))
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp do_count_trees(map, slope) do
    {0, 0}
    |> Stream.unfold(fn pos ->
      next_pos = add(pos, slope)
      {next_pos, next_pos}
    end)
    |> Stream.take_while(&on_map?(map, &1))
    |> Enum.count(&tree?(map, &1))
  end

  defp on_map?(map, {x, y}) when x >= 0 and y >= 0 do
    y < map.height
  end

  defp tree?(map, {x, y}) do
    x_pattern = rem(x, map.width)
    on_map?(map, {x, y}) and {x_pattern, y} in map.trees
  end

  defp add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

  defp parse(input) do
    lines =
      input
      |> String.trim()
      |> String.split("\n", trim: true)

    %{
      width: lines |> hd() |> String.length(),
      height: length(lines),
      trees: parse_trees(lines)
    }
  end

  defp parse_trees(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, y}, trees ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _x} -> char == "#" end)
      |> Enum.reduce(trees, fn {_char, x}, trees ->
        MapSet.put(trees, {x, y})
      end)
    end)
  end
end
