defmodule Advent.Day19Test do
  use ExUnit.Case

  alias Advent.Day19

  describe "part 1" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day19.part_1(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_1() == :foo
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day19.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_2() == :foo
    end
  end
end
