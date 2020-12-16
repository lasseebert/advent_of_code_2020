defmodule Advent.Day15Test do
  use ExUnit.Case

  alias Advent.Day15

  describe "part 1" do
    test "example 1" do
      assert Day15.part_1("0,3,6") == 436
    end

    test "example 2" do
      assert Day15.part_1("1,3,2") == 1
    end

    test "example 3" do
      assert Day15.part_1("2,1,3") == 10
    end

    test "example 4" do
      assert Day15.part_1("1,2,3") == 27
    end

    test "example 5" do
      assert Day15.part_1("2,3,1") == 78
    end

    test "example 6" do
      assert Day15.part_1("3,2,1") == 438
    end

    test "example 7" do
      assert Day15.part_1("3,1,2") == 1836
    end

    test "puzzle input" do
      assert Day15.part_1("1,17,0,10,18,11,6") == 595
    end
  end

  describe "part 2" do
    test "example 1" do
      assert Day15.part_2("0,3,6") == 175_594
    end

    test "example 2" do
      assert Day15.part_2("1,3,2") == 2578
    end

    test "example 3" do
      assert Day15.part_2("2,1,3") == 3_544_142
    end

    test "example 4" do
      assert Day15.part_2("1,2,3") == 261_214
    end

    test "example 5" do
      assert Day15.part_2("2,3,1") == 6_895_259
    end

    test "example 6" do
      assert Day15.part_2("3,2,1") == 18
    end

    test "example 7" do
      assert Day15.part_2("3,1,2") == 362
    end

    test "puzzle input" do
      assert Day15.part_2("1,17,0,10,18,11,6") == 1708310
    end
  end
end
