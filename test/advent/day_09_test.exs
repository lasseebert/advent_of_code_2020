defmodule Advent.Day09Test do
  use ExUnit.Case

  alias Advent.Day09

  describe "part 1" do
    test "example" do
      input = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """

      assert Day09.part_1(input, 5) == 127
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_09.txt"
             |> File.read!()
             |> Day09.part_1() == 542_529_149
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day09.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_09.txt"
             |> File.read!()
             |> Day09.part_2() == :foo
    end
  end
end
