defmodule Advent.Day21Test do
  use ExUnit.Case

  alias Advent.Day21

  describe "part 1" do
    test "example" do
      input = """
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
      """

      assert Day21.part_1(input) == 5
    end

    test "translated example" do
      input = """
      a b c d (contains dairy, fish)
      e f g a (contains dairy)
      c f (contains soy)
      c a g (contains fish)
      """

      # In the above example, none of the ingredients b, d, g, or e can contain an allergen.

      assert Day21.part_1(input) == 5
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_21.txt"
             |> File.read!()
             |> Day21.part_1() == 2389
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      input = """
      """

      assert Day21.part_2(input) == :foo
    end

    @tag :skip
    test "puzzle input" do
      assert "puzzle_inputs/day_21.txt"
             |> File.read!()
             |> Day21.part_2() == :foo
    end
  end
end
