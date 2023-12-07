defmodule Advent.Day07Test do
  use ExUnit.Case, async: true

  alias Advent.Day07

  @example_input """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  describe "Parser.round/1" do
    test "turns the hands into tuples that can be sorted alongside the bid" do
      assert Day07.Parser.round(@example_input) == [
               %{bid: 765, hand: ~c"32T3K"},
               %{bid: 684, hand: ~c"T55J5"},
               %{bid: 28, hand: ~c"KK677"},
               %{bid: 220, hand: ~c"KTJJT"},
               %{bid: 483, hand: ~c"QQQJA"}
             ]
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day07.part_one(@example_input) == 6440
    end

    test "input" do
      input = File.read!("priv/inputs/day-07.txt")
      assert Day07.part_one(input) == 249_726_565
    end
  end

  describe "part_two/1" do
    test "example input" do
      assert Day07.part_two(@example_input) == 5905
    end

    test "input" do
      input = File.read!("priv/inputs/day-07.txt")
      assert Day07.part_two(input) == 251_135_960
    end
  end
end
