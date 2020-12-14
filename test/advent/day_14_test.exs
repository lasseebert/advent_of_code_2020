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
    test "example" do
      input = """
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
      """

      assert Day14.part_2(input) == 208
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_14.txt"
             |> File.read!()
             |> Day14.part_2() == 4_832_039_794_082
    end
  end
end
