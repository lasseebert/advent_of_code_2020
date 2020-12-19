defmodule Advent.Day19Test do
  use ExUnit.Case

  alias Advent.Day19

  describe "part 1" do
    test "example" do
      input = """
      0: 4 1 5
      1: 2 3 | 3 2
      2: 4 4 | 5 5
      3: 4 5 | 5 4
      4: "a"
      5: "b"

      ababbb
      bababa
      abbbab
      aaabbb
      aaaabbb
      """

      assert Day19.part_1(input) == 2
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_1() == :foo
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day19.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_2() == :foo
    end
  end
end
