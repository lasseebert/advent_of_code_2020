defmodule Advent.Day10Test do
  use ExUnit.Case

  alias Advent.Day10

  describe "part 1" do
    test "example 1" do
      input = """
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
      """

      assert Day10.part_1(input) == 35
    end

    test "example 2" do
      input = """
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
      """

      assert Day10.part_1(input) == 220
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_10.txt"
             |> File.read!()
             |> Day10.part_1() == 1920
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day10.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_10.txt"
             |> File.read!()
             |> Day10.part_2() == :foo
    end
  end
end
