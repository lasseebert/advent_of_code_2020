defmodule Advent.Day14Test do
  use ExUnit.Case

  alias Advent.Day14

  describe "part 1" do
    test "example" do
      input = """
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      """

      assert Day14.part_1(input) == 165
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_14.txt"
             |> File.read!()
             |> Day14.part_1() == 8_566_770_985_168
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day14.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_14.txt"
             |> File.read!()
             |> Day14.part_2() == :foo
    end
  end
end
