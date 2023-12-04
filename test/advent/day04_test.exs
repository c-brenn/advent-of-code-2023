defmodule Advent.Day04Test do
  use ExUnit.Case, async: true

  alias Advent.Day04
  alias Advent.Day04.Card

  describe "to_cards/1" do
    test "turns the input into a list of cards" do
      input = """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """

      assert Day04.to_cards(input) == [
               %Card{winning: [41, 48, 83, 86, 17], given: [83, 86, 6, 31, 17, 9, 48, 53]},
               %Card{winning: [13, 32, 20, 16, 61], given: [61, 30, 68, 82, 17, 32, 24, 19]},
               %Card{winning: [1, 21, 53, 59, 44], given: [69, 82, 63, 72, 16, 21, 14, 1]},
               %Card{winning: [41, 92, 73, 84, 69], given: [59, 84, 76, 51, 58, 5, 54, 83]},
               %Card{winning: [87, 83, 26, 28, 32], given: [88, 30, 70, 12, 93, 22, 82, 36]},
               %Card{winning: [31, 18, 13, 56, 72], given: [74, 77, 10, 23, 35, 67, 36, 11]}
             ]
    end
  end

  describe "part_one/1" do
    test "example input" do
      input = """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """

      assert Day04.part_one(input) == 13
    end

    test "input" do
      input = File.read!("priv/inputs/day-04.txt")

      assert Day04.part_one(input) == 20829
    end
  end

  describe "part_two/1" do
    test "example input" do
      input = """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """

      assert Day04.part_two(input) == 30
    end

    test "input" do
      input = File.read!("priv/inputs/day-04.txt")

      assert Day04.part_two(input) == 12_648_035
    end
  end
end
