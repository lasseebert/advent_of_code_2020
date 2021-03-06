defmodule Advent.Day05Test do
  use ExUnit.Case

  alias Advent.Day05

  describe "part 1" do
    test "example" do
      input = """
      FBFBBFFRLR
      """

      assert Day05.part_1(input) == 357
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_05.txt"
             |> File.read!()
             |> Day05.part_1() == 894
    end
  end

  describe "part 2" do
    test "puzzle input" do
      assert "puzzle_inputs/day_05.txt"
             |> File.read!()
             |> Day05.part_2() == 579
    end
  end
end
