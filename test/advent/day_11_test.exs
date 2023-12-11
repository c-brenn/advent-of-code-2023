defmodule Advent.Day11Test do
  use ExUnit.Case, async: true

  alias Advent.Day11

  describe "Parser.image/1" do
    test "turns the image into a list of galaxies and their coordinates" do
      input = """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """

      assert Day11.Parser.image(input) == %{
               galaxies: [
                 {9, 4},
                 {9, 0},
                 {8, 7},
                 {6, 9},
                 {5, 1},
                 {4, 6},
                 {2, 0},
                 {1, 7},
                 {0, 3}
               ],
               non_empty_columns: MapSet.new([0, 1, 3, 4, 6, 7, 9]),
               non_empty_rows: MapSet.new([0, 1, 2, 4, 5, 6, 8, 9])
             }
    end
  end

  describe "expand/2" do
    test "expands the empty sections of the universe" do
      input = """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """

      state = Day11.Parser.image(input)

      expanded = Day11.expand(state, 2)

      assert expanded == [
               {11, 5},
               {11, 0},
               {10, 9},
               {7, 12},
               {6, 1},
               {5, 8},
               {2, 0},
               {1, 9},
               {0, 4}
             ]

      expanded_image = """
      ....#........
      .........#...
      #............
      .............
      .............
      ........#....
      .#...........
      ............#
      .............
      .............
      .........#...
      #....#.......
      """

      assert expanded == Day11.Parser.image(expanded_image).galaxies
    end
  end

  describe "part_one/1" do
    test "example input" do
      input = """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """

      assert Day11.part_one(input) == 374
    end

    test "input" do
      input = File.read!("priv/inputs/day-11.txt")
      assert Day11.part_one(input) == 9_509_330
    end
  end

  describe "part_two/2" do
    test "example input" do
      input = """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """

      assert Day11.part_two(input, factor: 10) == 1030
      assert Day11.part_two(input, factor: 100) == 8410
    end

    test "input" do
      input = File.read!("priv/inputs/day-11.txt")
      assert Day11.part_two(input, factor: 1_000_000) == 635_832_237_682
    end
  end
end
