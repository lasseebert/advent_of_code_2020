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
    test "example 1" do
      input = """
      939
      7,13,x,x,59,x,31,19
      """

      assert Day13.part_2(input) == 1_068_781
    end

    test "example 2" do
      assert Day13.part_2("0\n17,x,13,19") == 3417
    end

    test "example 3" do
      assert Day13.part_2("0\n67,7,59,61") == 754_018
    end

    test "example 4" do
      assert Day13.part_2("0\n67,x,7,59,61") == 779_210
    end

    test "example 5" do
      assert Day13.part_2("0\n67,7,x,59,61") == 1_261_476
    end

    test "example 6" do
      assert Day13.part_2("0\n1789,37,47,1889") == 1_202_161_486
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_13.txt"
             |> File.read!()
             |> Day13.part_2() == 626_670_513_163_231
    end
  end
end
