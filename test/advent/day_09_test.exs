defmodule Advent.Day09Test do
  use ExUnit.Case, async: true

  alias Advent.Day09

  @example_input """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  describe "Parser.readings/1[]" do
    test "extracts the list of readings over time" do
      assert Day09.Parser.readings(@example_input) == [
               [0, 3, 6, 9, 12, 15],
               [1, 3, 6, 10, 15, 21],
               [10, 13, 16, 21, 30, 45]
             ]
    end

    test "can handle negative readings" do
      input = """
      0 3 6 9 12 15
      1 -3 6 -10 15 21
      """

      assert Day09.Parser.readings(input) == [
               [0, 3, 6, 9, 12, 15],
               [1, -3, 6, -10, 15, 21]
             ]
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day09.part_one(@example_input) == 114
    end

    test "input" do
      input = File.read!("priv/inputs/day-09.txt")
      assert Day09.part_one(input) == 1_637_452_029
    end
  end

  describe "part_two/1" do
    test "example input" do
      assert Day09.part_two(@example_input) == 2
    end

    test "input" do
      input = File.read!("priv/inputs/day-09.txt")
      assert Day09.part_two(input) == 908
    end
  end
end
