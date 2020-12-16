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
    test "example" do
      input = """
      class: 0-1 or 4-19
      row: 0-5 or 8-19
      seat: 0-13 or 16-19

      your ticket:
      11,12,13

      nearby tickets:
      3,9,18
      15,1,5
      5,14,9
      """

      assert Day16.part_2(input) == %{
               "row" => 11,
               "class" => 12,
               "seat" => 13
             }
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_16.txt"
             |> File.read!()
             |> Day16.part_2()
             |> Enum.filter(fn {name, _value} -> String.starts_with?(name, "departure") end)
             |> Enum.map(&elem(&1, 1))
             |> Enum.reduce(fn a, b -> a * b end) == 4_381_476_149_273
    end
  end
end
