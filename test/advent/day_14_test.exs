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
