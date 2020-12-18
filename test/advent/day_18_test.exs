defmodule Advent.Day18Test do
  use ExUnit.Case

  alias Advent.Day18

  describe "part 1" do
    test "example 1" do
      assert Day18.part_1("1 + 2 * 3 + 4 * 5 + 6") == 71
    end

    test "example 2" do
      assert Day18.part_1("1 + (2 * 3) + (4 * (5 + 6))") == 51
    end

    test "example 3" do
      assert Day18.part_1("2 * 3 + (4 * 5)") == 26
    end

    test "example 4" do
      assert Day18.part_1("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    end

    test "example 5" do
      assert Day18.part_1("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12_240
    end

    test "example 6" do
      assert Day18.part_1("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13_632
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_18.txt"
             |> File.read!()
             |> Day18.part_1() == 510_009_915_468
    end
  end

  describe "part 2" do
    test "example 1" do
      assert Day18.part_2("1 + 2 * 3 + 4 * 5 + 6") == 231
    end

    test "example 2" do
      assert Day18.part_2("1 + (2 * 3) + (4 * (5 + 6))") == 51
    end

    test "example 3" do
      assert Day18.part_2("2 * 3 + (4 * 5)") == 46
    end

    test "example 4" do
      assert Day18.part_2("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
    end

    test "example 5" do
      assert Day18.part_2("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 669_060
    end

    test "example 6" do
      assert Day18.part_2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23_340
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_18.txt"
             |> File.read!()
             |> Day18.part_2() == 321_176_691_637_769
    end
  end
end
