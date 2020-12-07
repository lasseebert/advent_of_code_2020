defmodule Advent.Day07Test do
  use ExUnit.Case

  alias Advent.Day07

  describe "part 1" do
    test "example" do
      input = """
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
      """

      assert Day07.part_1(input) == 4
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_07.txt"
             |> File.read!()
             |> Day07.part_1() == 226
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day07.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_07.txt"
             |> File.read!()
             |> Day07.part_2() == :foo
    end
  end
end
