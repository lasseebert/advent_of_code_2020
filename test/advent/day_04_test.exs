defmodule Advent.Day04Test do
  use ExUnit.Case

  alias Advent.Day04

  describe "part 1" do
    test "example" do
      input = """
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
      """

      assert Day04.part_1(input) == 2
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_04.txt"
             |> File.read!()
             |> Day04.part_1() == 228
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day04.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_04.txt"
             |> File.read!()
             |> Day04.part_2() == :foo
    end
  end
end
