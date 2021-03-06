defmodule Advent.Day17Test do
  use ExUnit.Case

  alias Advent.Day17

  describe "part 1" do
    test "example" do
      input = """
      .#.
      ..#
      ###
      """

      assert Day17.part_1(input) == 112
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_17.txt"
             |> File.read!()
             |> Day17.part_1() == 315
    end
  end

  describe "part 2" do
    test "example" do
      input = """
      .#.
      ..#
      ###
      """

      assert Day17.part_2(input) == 848
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_17.txt"
             |> File.read!()
             |> Day17.part_2() == 1520
    end
  end
end
