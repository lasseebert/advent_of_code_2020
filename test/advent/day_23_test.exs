defmodule Advent.Day23Test do
  use ExUnit.Case

  alias Advent.Day23

  describe "part 1" do
    test "example" do
      assert Day23.part_1("389125467") == 67384529
    end

    test "puzzle input" do
      assert Day23.part_1("158937462") == 69473825
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day23.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_23.txt"
             |> File.read!()
             |> Day23.part_2() == :foo
    end
  end
end
