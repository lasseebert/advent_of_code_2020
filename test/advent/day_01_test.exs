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

  describe "part 2" do
    test "example" do
      input = """
      1721
      979
      366
      299
      675
      1456
      """

      assert Day01.find_2020_sum_3(input) == 241_861_950
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_01.txt"
             |> File.read!()
             |> Day01.find_2020_sum_3() == 9_199_664
    end
  end
end
