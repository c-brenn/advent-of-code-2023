defmodule Advent.Day05Test do
  use ExUnit.Case, async: true

  alias Advent.Day05

  @example_input """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  describe "Parser.almanac" do
    test "extracts the seed and map information" do
      assert Day05.Parser.almanac(@example_input) == %{
               seeds: [79, 14, 55, 13],
               seed_to_soil: [
                 %{dest: {50, 51}, source: {98, 99}},
                 %{dest: {52, 99}, source: {50, 97}}
               ],
               soil_to_fertilizer: [
                 %{dest: {0, 36}, source: {15, 51}},
                 %{dest: {37, 38}, source: {52, 53}},
                 %{dest: {39, 53}, source: {0, 14}}
               ],
               fertilizer_to_water: [
                 %{dest: {49, 56}, source: {53, 60}},
                 %{dest: {0, 41}, source: {11, 52}},
                 %{dest: {42, 48}, source: {0, 6}},
                 %{dest: {57, 60}, source: {7, 10}}
               ],
               water_to_light: [
                 %{dest: {88, 94}, source: {18, 24}},
                 %{dest: {18, 87}, source: {25, 94}}
               ],
               light_to_temperature: [
                 %{dest: {45, 67}, source: {77, 99}},
                 %{dest: {81, 99}, source: {45, 63}},
                 %{dest: {68, 80}, source: {64, 76}}
               ],
               temperature_to_humidity: [
                 %{dest: {0, 0}, source: {69, 69}},
                 %{dest: {1, 69}, source: {0, 68}}
               ],
               humidity_to_location: [
                 %{dest: {60, 96}, source: {56, 92}},
                 %{dest: {56, 59}, source: {93, 96}}
               ]
             }
    end
  end

  describe "part_one" do
    test "example input" do
      assert Day05.part_one(@example_input) == 35
    end

    test "input" do
      almanac = File.read!("priv/inputs/day-05.txt")

      assert Day05.part_one(almanac) == 289_863_851
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day05.part_two(@example_input) == 46
    end

    @tag timeout: :infinity
    test "input" do
      almanac = File.read!("priv/inputs/day-05.txt")

      assert Day05.part_two(almanac) == 60_568_880
    end
  end
end
