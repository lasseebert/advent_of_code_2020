defmodule Advent.Day12Test do
  use ExUnit.Case

  alias Advent.Day12

  describe "part 1" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day12.part_1(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_12.txt"
             |> File.read!()
             |> Day12.part_1() == :foo
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
