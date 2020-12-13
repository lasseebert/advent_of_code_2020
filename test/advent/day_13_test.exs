defmodule Advent.Day13Test do
  use ExUnit.Case

  alias Advent.Day13

  describe "part 1" do
    test "example" do
      input = """
      939
      7,13,x,x,59,x,31,19
      """

      assert Day13.part_1(input) == 295
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_13.txt"
             |> File.read!()
             |> Day13.part_1() == 6559
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day13.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_13.txt"
             |> File.read!()
             |> Day13.part_2() == :foo
    end
  end
end
