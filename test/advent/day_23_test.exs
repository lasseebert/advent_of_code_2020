defmodule Advent.Day23Test do
  use ExUnit.Case

  alias Advent.Day23

  describe "part 1" do
    test "example" do
      assert Day23.part_1("389125467") == "67384529"
    end

    test "puzzle input" do
      assert Day23.part_1("158937462") == "69473825"
    end
  end

  describe "part 2" do
    test "example" do
      assert Day23.part_2("389125467") == "149245887792"
    end

    test "puzzle input" do
      assert Day23.part_2("158937462") == :foo
    end
  end
end
