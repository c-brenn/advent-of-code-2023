defmodule Advent.Day12Test do
  use ExUnit.Case, async: true

  alias Advent.Day12

  describe "Parser.condition_records" do
    test "extracts the record and groups for each line" do
      input = """
      #.#.### 1,1,3
      .#...#....###. 1,1,3
      .#.###.#.###### 1,3,1,6
      ####.#...#... 4,1,1
      #....######..#####. 1,6,5
      .###.##....# 3,2,1
      """

      assert Day12.Parser.condition_records(input) == [
               %{record: ~c"#.#.###", groups: [1, 1, 3]},
               %{record: ~c".#...#....###.", groups: [1, 1, 3]},
               %{record: ~c".#.###.#.######", groups: [1, 3, 1, 6]},
               %{record: ~c"####.#...#...", groups: [4, 1, 1]},
               %{record: ~c"#....######..#####.", groups: [1, 6, 5]},
               %{record: ~c".###.##....#", groups: [3, 2, 1]}
             ]

      input = """
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
      """

      assert Day12.Parser.condition_records(input) == [
               %{record: ~c"???.###", groups: [1, 1, 3]},
               %{record: ~c".??..??...?##.", groups: [1, 1, 3]},
               %{record: ~c"?#?#?#?#?#?#?#?", groups: [1, 3, 1, 6]},
               %{record: ~c"????.#...#...", groups: [4, 1, 1]},
               %{record: ~c"????.######..#####.", groups: [1, 6, 5]},
               %{record: ~c"?###????????", groups: [3, 2, 1]}
             ]
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day12.part_one("???.### 1,1,3") == 1
      assert Day12.part_one(".??..??...?##. 1,1,3") == 4
      assert Day12.part_one("?###???????? 3,2,1") == 10

      input = """
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
      """

      assert Day12.part_one(input) == 21
    end

    test "input" do
      input = File.read!("priv/inputs/day-12.txt")
      assert Day12.part_one(input) == 7674
    end
  end

  describe "part_two/1" do
    test "input" do
      input = File.read!("priv/inputs/day-12.txt")
      assert Day12.part_two(input) == 4_443_895_258_186
    end
  end
end
