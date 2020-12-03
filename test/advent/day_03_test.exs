defmodule Advent.Day03Test do
  use ExUnit.Case

  alias Advent.Day03

  describe "part 1" do
    test "example" do
      input = """
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
      """

      assert Day03.count_trees(input) == 7
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_03.txt"
             |> File.read!()
             |> Day03.count_trees() == 191
    end
  end

  describe "part 2" do
    test "example" do
      input = """
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
      """

      assert Day03.count_trees_multi(input) == 336
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_03.txt"
             |> File.read!()
             |> Day03.count_trees_multi() == 1_478_615_040
    end
  end
end
