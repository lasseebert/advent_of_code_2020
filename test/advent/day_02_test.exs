defmodule Advent.Day02Test do
  use ExUnit.Case

  alias Advent.Day02

  describe "part 1" do
    test "example" do
      input = """
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
      """

      assert Day02.count_valid_passwords_part_1(input) == 2
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_02.txt"
             |> File.read!()
             |> Day02.count_valid_passwords_part_1() == 603
    end
  end

  describe "part 2" do
    test "example" do
      input = """
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
      """

      assert Day02.count_valid_passwords_part_2(input) == 1
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_02.txt"
             |> File.read!()
             |> Day02.count_valid_passwords_part_2() == 404
    end
  end
end
