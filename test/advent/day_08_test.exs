defmodule Advent.Day08Test do
  use ExUnit.Case

  alias Advent.Day08

  describe "part 1" do
    test "example" do
      input = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """

      assert Day08.part_1(input) == 5
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_08.txt"
             |> File.read!()
             |> Day08.part_1() == 1384
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day08.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_08.txt"
             |> File.read!()
             |> Day08.part_2() == :foo
    end
  end
end
