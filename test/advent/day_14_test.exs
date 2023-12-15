defmodule Advent.Day14Test do
  use ExUnit.Case, async: true

  alias Advent.Day14

  @example_input """
  O....#....
  O.OO#....#
  .....##...
  OO.#O....O
  .O.....O#.
  O.#..O.#.#
  ..O..#O..O
  .......O..
  #....###..
  #OO..#....
  """

  describe "Parser.columns/1" do
    test "transposes the grid so the columns become rows" do
      assert Day14.Parser.columns(@example_input) == [
               ~c"OO.O.O..##",
               ~c"...OO....O",
               ~c".O...#O..O",
               ~c".O.#......",
               ~c".#.O......",
               ~c"#.#..O#.##",
               ~c"..#...O.#.",
               ~c"....O#.O#.",
               ~c"....#.....",
               ~c".#.O.#O..."
             ]
    end
  end

  describe "tilt/1" do
    test "example input" do
      columns = Day14.Parser.columns(@example_input)

      expected =
        """
        OOOO.#.O..
        OO..#....#
        OO..O##..O
        O..#.OO...
        ........#.
        ..#....#.#
        ..O..#.O.O
        ..O.......
        #....###..
        #....#....
        """
        |> Day14.Parser.columns()

      assert Day14.tilt(columns) == expected
    end
  end

  describe "rotate/1" do
    test "rotates -90 degrees" do
      north = Day14.Parser.columns(@example_input)

      assert north
             |> Day14.rotate(:north_to_west)
             |> Day14.rotate(:west_to_south)
             |> Day14.rotate(:south_to_east)
             |> Day14.rotate(:east_to_north) ==
               north

      west = Day14.rotate(north, :north_to_west)

      assert west == [
               ~c"O....#....",
               ~c"O.OO#....#",
               ~c".....##...",
               ~c"OO.#O....O",
               ~c".O.....O#.",
               ~c"O.#..O.#.#",
               ~c"..O..#O..O",
               ~c".......O..",
               ~c"#....###..",
               ~c"#OO..#...."
             ]

      south = Day14.rotate(west, :west_to_south)

      assert south == [
               ~c"...O#.O.#.",
               ~c".....#....",
               ~c".#O.#O....",
               ~c".#.O...#..",
               ~c"##.#O..#.#",
               ~c"......O.#.",
               ~c"......#.O.",
               ~c"O..O#...O.",
               ~c"O....OO...",
               ~c"##..O.O.OO"
             ]

      east = Day14.rotate(south, :south_to_east)

      assert east == [
               ~c"....#..OO#",
               ~c"..###....#",
               ~c"..O.......",
               ~c"O..O#..O..",
               ~c"#.#.O..#.O",
               ~c".#O.....O.",
               ~c"O....O#.OO",
               ~c"...##.....",
               ~c"#....#OO.O",
               ~c"....#....O"
             ]

      assert Day14.rotate(east, :east_to_north) == north
    end
  end

  describe "cycle/1" do
    test "tilts in each direction" do
      grid = Day14.Parser.columns(@example_input)

      expected =
        """
        .....#....
        ....#...O#
        ...OO##...
        .OO#......
        .....OOO#.
        .O#...O#.#
        ....O#....
        ......OOOO
        #...O###..
        #..OO#....
        """
        |> Day14.Parser.columns()

      assert Day14.cycle(grid) == expected
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day14.part_one(@example_input) == 136
    end

    test "input" do
      input = File.read!("priv/inputs/day-14.txt")

      assert Day14.part_one(input) == 108_955
    end
  end

  describe "part_two/1" do
    test "example input" do
      assert Day14.part_two(@example_input) == 64
    end

    test "input" do
      input = File.read!("priv/inputs/day-14.txt")
      assert Day14.part_two(input) == 106_689
    end
  end
end
