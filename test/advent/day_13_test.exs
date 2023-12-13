defmodule Advent.Day13Test do
  use ExUnit.Case, async: true

  alias Advent.Day13

  def grid_to_s(grid) do
    grid
    |> Map.keys()
    |> Enum.sort(:asc)
    |> Enum.group_by(fn {y, _} -> y end)
    |> Enum.map(fn {_, coords} ->
      coords
      |> Enum.map(&Map.get(grid, &1))
      |> to_string()
    end)
    |> Enum.join("\n")
  end

  describe "transpose/1" do
    test "flips the grid across the diagonal degrees" do
      input = """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.
      """

      assert [grid] = Day13.Parser.grids(input)

      assert grid |> Day13.transpose() |> grid_to_s() == """
             #.##..#
             ..##...
             ##..###
             #....#.
             .#..#.#
             .#..#.#
             #....#.
             ##..###
             ..##...\
             """
    end
  end

  describe "part_one/1" do
    test "example input" do
      input = """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.
      """

      assert Day13.part_one(input) == 5

      input = """
      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
      """

      assert Day13.part_one(input) == 400

      input = """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
      """

      assert Day13.part_one(input) == 405
    end

    test "input" do
      input = File.read!("priv/inputs/day-13.txt")
      assert Day13.part_one(input) == 26957
    end
  end

  describe "part_two/1" do
    test "example input" do
      input = """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
      """

      assert Day13.part_two(input) == 400
    end

    test "input" do
      input = File.read!("priv/inputs/day-13.txt")
      assert Day13.part_two(input) == 42695
    end
  end
end
