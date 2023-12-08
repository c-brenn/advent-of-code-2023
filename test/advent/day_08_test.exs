defmodule Advent.Day08Test do
  use ExUnit.Case, async: true

  alias Advent.Day08

  @example_input """
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
  """

  describe "Parser.graph/1" do
    test "extracts the directions and graph" do
      assert Day08.Parser.graph(@example_input) == %{
               directions: ~c"RL",
               nodes: %{
                 ~c"AAA" => {~c"BBB", ~c"CCC"},
                 ~c"BBB" => {~c"DDD", ~c"EEE"},
                 ~c"CCC" => {~c"ZZZ", ~c"GGG"},
                 ~c"DDD" => {~c"DDD", ~c"DDD"},
                 ~c"EEE" => {~c"EEE", ~c"EEE"},
                 ~c"GGG" => {~c"GGG", ~c"GGG"},
                 ~c"ZZZ" => {~c"ZZZ", ~c"ZZZ"}
               }
             }
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day08.part_one(@example_input) == 2
    end

    test "cycle example" do
      input = """
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      """

      assert Day08.part_one(input) == 6
    end

    test "input" do
      input = File.read!("priv/inputs/day-08.txt")
      assert Day08.part_one(input) == 20569
    end
  end

  describe "part_two/1" do
    test "example input" do
      input = """
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
      """

      assert Day08.part_two(input) == 6
    end

    test "input" do
      input = File.read!("priv/inputs/day-08.txt")
      assert Day08.part_two(input) == 21_366_921_060_721
    end
  end
end
