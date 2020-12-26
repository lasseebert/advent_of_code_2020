defmodule Advent.Day25Test do
  use ExUnit.Case

  alias Advent.Day25

  describe "part 1" do
    test "example" do
      input = """
      5764801
      17807724
      """

      assert Day25.part_1(input) == 14_897_079
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_25.txt"
             |> File.read!()
             |> Day25.part_1() == 8_329_514
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day25.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_25.txt"
             |> File.read!()
             |> Day25.part_2() == :foo
    end
  end
end
