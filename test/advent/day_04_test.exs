defmodule Advent.Day04Test do
  use ExUnit.Case

  alias Advent.Day04

  describe "part 1" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day04.part_1(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_04.txt"
             |> File.read!()
             |> Day04.part_1() == :foo
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day04.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_04.txt"
             |> File.read!()
             |> Day04.part_2() == :foo
    end
  end
end
