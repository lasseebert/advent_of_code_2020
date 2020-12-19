defmodule Advent.Day19Test do
  use ExUnit.Case

  alias Advent.Day19

  describe "part 1" do
    test "example" do
      input = """
      0: 4 1 5
      1: 2 3 | 3 2
      2: 4 4 | 5 5
      3: 4 5 | 5 4
      4: "a"
      5: "b"

      ababbb
      bababa
      abbbab
      aaabbb
      aaaabbb
      """

      assert Day19.part_1(input) == 2
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_1() == 213
    end
  end

  describe "part 2" do
    defp example_input(messages) do
      grammar = """
      42: 9 14 | 10 1
      9: 14 27 | 1 26
      10: 23 14 | 28 1
      1: "a"
      11: 42 31
      5: 1 14 | 15 1
      19: 14 1 | 14 14
      12: 24 14 | 19 1
      16: 15 1 | 14 14
      31: 14 17 | 1 13
      6: 14 14 | 1 14
      2: 1 24 | 14 4
      0: 8 11
      13: 14 3 | 1 12
      15: 1 | 14
      17: 14 2 | 1 7
      23: 25 1 | 22 14
      28: 16 1
      4: 1 1
      20: 14 14 | 1 15
      3: 5 14 | 16 1
      27: 1 6 | 14 18
      14: "b"
      21: 14 1 | 1 14
      25: 1 1 | 1 14
      22: 14 14
      8: 42
      26: 14 22 | 1 20
      18: 15 15
      7: 14 5 | 1 21
      24: 14 1
      """

      "#{grammar}\n#{messages}"
    end

    test "example" do
      input =
        """
        abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
        bbabbbbaabaabba
        babbbbaabbbbbabbbbbbaabaaabaaa
        aaabbbbbbaaaabaababaabababbabaaabbababababaaa
        bbbbbbbaaaabbbbaaabbabaaa
        bbbababbbbaaaaaaaabbababaaababaabab
        ababaaaaaabaaab
        ababaaaaabbbaba
        baabbaaaabbaaaababbaababb
        abbbbabbbbaaaababbbbbbaaaababb
        aaaaabbaabaaaaababaa
        aaaabbaaaabbaaa
        aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
        babaaabbbaaabaababbaabababaaab
        aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
        """
        |> example_input()

      assert Day19.part_2(input) == 12
    end

    @valid """
           bbabbbbaabaabba
           babbbbaabbbbbabbbbbbaabaaabaaa
           aaabbbbbbaaaabaababaabababbabaaabbababababaaa
           bbbbbbbaaaabbbbaaabbabaaa
           bbbababbbbaaaaaaaabbababaaababaabab
           ababaaaaaabaaab
           ababaaaaabbbaba
           baabbaaaabbaaaababbaababb
           abbbbabbbbaaaababbbbbbaaaababb
           aaaaabbaabaaaaababaa
           aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
           aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
           """
           |> String.split("\n", trim: true)

    """
    abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
    bbabbbbaabaabba
    babbbbaabbbbbabbbbbbaabaaabaaa
    aaabbbbbbaaaabaababaabababbabaaabbababababaaa
    bbbbbbbaaaabbbbaaabbabaaa
    bbbababbbbaaaaaaaabbababaaababaabab
    ababaaaaaabaaab
    ababaaaaabbbaba
    baabbaaaabbaaaababbaababb
    abbbbabbbbaaaababbbbbbaaaababb
    aaaaabbaabaaaaababaa
    aaaabbaaaabbaaa
    aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
    babaaabbbaaabaababbaabababaaab
    aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
    """
    |> String.split("\n", trim: true)
    |> Enum.each(fn message ->
      expected =
        if message in @valid do
          1
        else
          0
        end

      if not String.starts_with?(message, "#") do
        test "part example #{message}" do
          assert unquote(message) |> example_input() |> Day19.part_2() == unquote(expected)
        end
      end
    end)

    test "puzzle input" do
      assert "puzzle_inputs/day_19.txt"
             |> File.read!()
             |> Day19.part_2() == 325
    end
  end
end
