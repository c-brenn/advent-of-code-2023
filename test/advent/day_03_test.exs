defmodule Advent.Day03Test do
  use ExUnit.Case, async: true

  alias Advent.Day03

  describe "matrix/1" do
    test "transforms the schematic into a map-based matrix (ignoring dots)" do
      schematic = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert Day03.matrix(schematic) == %{
               {1, 1} => %{id: {1, 1}, value: {:part_number, 467}},
               {1, 2} => %{id: {1, 1}, value: {:part_number, 467}},
               {1, 3} => %{id: {1, 1}, value: {:part_number, 467}},
               {1, 6} => %{id: {1, 6}, value: {:part_number, 114}},
               {1, 7} => %{id: {1, 6}, value: {:part_number, 114}},
               {1, 8} => %{id: {1, 6}, value: {:part_number, 114}},
               {2, 4} => %{id: {2, 4}, value: {:symbol, 42}},
               {3, 3} => %{id: {3, 3}, value: {:part_number, 35}},
               {3, 4} => %{id: {3, 3}, value: {:part_number, 35}},
               {3, 7} => %{id: {3, 7}, value: {:part_number, 633}},
               {3, 8} => %{id: {3, 7}, value: {:part_number, 633}},
               {3, 9} => %{id: {3, 7}, value: {:part_number, 633}},
               {4, 7} => %{id: {4, 7}, value: {:symbol, 35}},
               {5, 1} => %{id: {5, 1}, value: {:part_number, 617}},
               {5, 2} => %{id: {5, 1}, value: {:part_number, 617}},
               {5, 3} => %{id: {5, 1}, value: {:part_number, 617}},
               {5, 4} => %{id: {5, 4}, value: {:symbol, 42}},
               {6, 6} => %{id: {6, 6}, value: {:symbol, 43}},
               {6, 8} => %{id: {6, 8}, value: {:part_number, 58}},
               {6, 9} => %{id: {6, 8}, value: {:part_number, 58}},
               {7, 3} => %{id: {7, 3}, value: {:part_number, 592}},
               {7, 4} => %{id: {7, 3}, value: {:part_number, 592}},
               {7, 5} => %{id: {7, 3}, value: {:part_number, 592}},
               {8, 7} => %{id: {8, 7}, value: {:part_number, 755}},
               {8, 8} => %{id: {8, 7}, value: {:part_number, 755}},
               {8, 9} => %{id: {8, 7}, value: {:part_number, 755}},
               {9, 4} => %{id: {9, 4}, value: {:symbol, 36}},
               {9, 6} => %{id: {9, 6}, value: {:symbol, 42}},
               {10, 2} => %{id: {10, 2}, value: {:part_number, 664}},
               {10, 3} => %{id: {10, 2}, value: {:part_number, 664}},
               {10, 4} => %{id: {10, 2}, value: {:part_number, 664}},
               {10, 6} => %{id: {10, 6}, value: {:part_number, 598}},
               {10, 7} => %{id: {10, 6}, value: {:part_number, 598}},
               {10, 8} => %{id: {10, 6}, value: {:part_number, 598}}
             }
    end
  end

  describe "part_one/1" do
    test "example input" do
      schematic = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert Day03.part_one(schematic) == 4361
    end

    test "input" do
      schematic = File.read!("priv/inputs/day-03.txt")

      assert Day03.part_one(schematic) == 536_576
    end
  end

  describe "part_two/1" do
    test "example input" do
      schematic = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert Day03.part_two(schematic) == 467_835
    end

    test "input" do
      schematic = File.read!("priv/inputs/day-03.txt")
      assert Day03.part_two(schematic) == 75_741_499
    end
  end
end
