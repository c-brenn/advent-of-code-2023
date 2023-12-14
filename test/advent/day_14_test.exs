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

  describe "tilt_north/1" do
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

      assert Day14.tilt_north(columns) == expected
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
end
