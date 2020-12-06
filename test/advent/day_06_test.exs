defmodule Advent.Day06Test do
  use ExUnit.Case

  alias Advent.Day06

  describe "part 1" do
    test "example" do
      input = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """

      assert Day06.part_1(input) == 11
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_06.txt"
             |> File.read!()
             |> Day06.part_1() == 6714
    end
  end

  describe "part 2" do
    test "example" do
      input = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """

      assert Day06.part_2(input) == 6
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_06.txt"
             |> File.read!()
             |> Day06.part_2() == 3435
    end
  end
end
