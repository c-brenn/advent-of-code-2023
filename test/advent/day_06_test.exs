defmodule Advent.Day06Test do
  use ExUnit.Case, async: true

  alias Advent.Day06

  @example_input """
  Time:      7  15   30
  Distance:  9  40  200
  """

  describe "Parser.race_records/1" do
    test "extracts the time and distance records for each race" do
      assert Day06.Parser.race_records(@example_input) == [
               {7, 9},
               {15, 40},
               {30, 200}
             ]
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day06.part_one(@example_input) == 288
    end

    test "input" do
      input = File.read!("priv/inputs/day-06.txt")
      assert Day06.part_one(input) == 2_449_062
    end
  end

  describe "part_two/1" do
    test "example_input" do
      assert Day06.part_two(@example_input) == 71503
    end

    test "input" do
      input = File.read!("priv/inputs/day-06.txt")
      assert Day06.part_two(input) == 33_149_631
    end
  end
end
