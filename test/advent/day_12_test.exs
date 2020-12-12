defmodule Advent.Day12Test do
  use ExUnit.Case

  alias Advent.Day12

  describe "part 1" do
    test "example" do
      input = """
      F10
      N3
      F7
      R90
      F11
      """

      assert Day12.part_1(input) == 25
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_12.txt"
             |> File.read!()
             |> Day12.part_1() == 2847
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day12.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_12.txt"
             |> File.read!()
             |> Day12.part_2() == :foo
    end
  end
end
