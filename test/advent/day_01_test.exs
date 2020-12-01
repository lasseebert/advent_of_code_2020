defmodule Advent.Day01Test do
  use ExUnit.Case

  alias Advent.Day01

  describe "part 1" do
    test "example" do
      input = """
      1721
      979
      366
      299
      675
      1456
      """

      assert Day01.find_2020_sum(input) == 514_579
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_01.txt"
             |> File.read!()
             |> Day01.find_2020_sum() == 842_016
    end
  end
end
