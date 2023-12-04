defmodule Advent.Day02Test do
  use ExUnit.Case, async: true

  alias Advent.Day02

  describe "max_by_colour/1" do
    test "returns the maximum occurrences of each colour in the given game" do
      games =
        """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

      maxes =
        String.split(games, "\n", trim: true)
        |> Enum.map(&Day02.max_by_colour/1)

      assert maxes == [
               %{red: 4, green: 2, blue: 6},
               %{red: 1, green: 3, blue: 4},
               %{red: 20, green: 13, blue: 6},
               %{red: 14, green: 3, blue: 15},
               %{red: 6, green: 3, blue: 2}
             ]
    end
  end

  describe "part_one/2" do
    test "example from problem spec" do
      games =
        """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

      cubes = %{red: 12, green: 13, blue: 14}

      assert Day02.part_one(games, cubes) == 8
    end

    test "input" do
      games = File.read!("priv/inputs/day-02.txt")
      cubes = %{red: 12, green: 13, blue: 14}
      assert Day02.part_one(games, cubes) == 2348
    end
  end

  describe "cube_power/1" do
    test "multiplies the fewest number of each colour cube required for the game" do
      games = """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      powers =
        games
        |> String.split("\n", trim: true)
        |> Enum.map(&Day02.cube_power/1)

      assert powers == [
               48,
               12,
               1560,
               630,
               36
             ]
    end
  end

  describe "part_two/1" do
    test "example from problem spec" do
      games = """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      assert Day02.part_two(games) == 2286
    end

    test "input" do
      games = File.read!("priv/inputs/day-02.txt")

      assert Day02.part_two(games) == 76008
    end
  end
end
