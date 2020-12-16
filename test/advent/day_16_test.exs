defmodule Advent.Day16Test do
  use ExUnit.Case

  alias Advent.Day16

  describe "part 1" do
    test "example" do
      input = """
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
      """

      assert Day16.part_1(input) == 71
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_16.txt"
             |> File.read!()
             |> Day16.part_1() == 30_869
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day16.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_16.txt"
             |> File.read!()
             |> Day16.part_2() == :foo
    end
  end
end
