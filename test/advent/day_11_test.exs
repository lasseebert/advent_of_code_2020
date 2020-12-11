defmodule Advent.Day11Test do
  use ExUnit.Case

  alias Advent.Day11

  describe "part 1" do
    test "example" do
      input = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      assert Day11.part_1(input) == 37
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_11.txt"
             |> File.read!()
             |> Day11.part_1() == 2321
    end
  end

  describe "part 2" do
    test "example" do
      input = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      assert Day11.part_2(input) == 26
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_11.txt"
             |> File.read!()
             |> Day11.part_2() == 2102
    end
  end
end
