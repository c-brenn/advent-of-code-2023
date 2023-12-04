defmodule Advent.Day01Test do
  use ExUnit.Case, async: true

  alias Advent.Day01

  describe "calibration_value/1" do
    test "returns a number made of the first and last digits in the string" do
      # part 1
      assert Day01.calibration_value("1abc2") == 12
      assert Day01.calibration_value("pqr3stu8vwx") == 38
      assert Day01.calibration_value("a1b2c3d4e5f") == 15
      assert Day01.calibration_value("treb7uchet") == 77

      # part 2
      assert Day01.calibration_value("two1nine") == 29
      assert Day01.calibration_value("eightwothree") == 83
      assert Day01.calibration_value("abcone2threexyz") == 13
      assert Day01.calibration_value("xtwone3four") == 24
      assert Day01.calibration_value("4nineeightseven2") == 42
      assert Day01.calibration_value("zoneight234") == 14
      assert Day01.calibration_value("7pqrstsixteen") == 76
    end
  end

  describe "sum_calibration_document" do
    test "sums the calibration value of each line of the document" do
      # part 1
      document = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """

      assert Day01.sum_calibration_document(document, include_words?: false) == 142

      # part 2
      document = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """

      assert Day01.sum_calibration_document(document) == 281
    end
  end

  test "part one" do
    value =
      "priv/inputs/day-01.txt"
      |> File.read!()
      |> Day01.sum_calibration_document(include_words?: false)

    assert value == 53194
  end

  test "part two" do
    value =
      "priv/inputs/day-01.txt"
      |> File.read!()
      |> Day01.sum_calibration_document(include_words?: true)

    assert value == 54249
  end
end
