defmodule Advent.Day15Test do
  use ExUnit.Case, async: true

  alias Advent.Day15

  @example_input "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

  describe "hash/1" do
    test "example input" do
      hashes =
        @example_input |> String.split(",", trim: true) |> Enum.map(&Day15.hash/1)

      assert hashes == [30, 253, 97, 47, 14, 180, 9, 197, 48, 214, 231]
    end
  end

  describe "part_one/1" do
    test "example input" do
      assert Day15.part_one(@example_input) == 1320
    end

    test "input" do
      input = File.read!("priv/inputs/day-15.txt")
      assert Day15.part_one(input) == 513_158
    end
  end

  describe "Parser.operation/1" do
    test "turns the label into an operation" do
      operations =
        @example_input
        |> String.split(",", trim: true)
        |> Enum.map(&Day15.Parser.operation/1)

      assert operations == [
               %{operation: {:assign, 1}, lense: ~c"rn"},
               %{operation: :remove, lense: ~c"cm"},
               %{operation: {:assign, 3}, lense: ~c"qp"},
               %{operation: {:assign, 2}, lense: ~c"cm"},
               %{operation: :remove, lense: ~c"qp"},
               %{operation: {:assign, 4}, lense: ~c"pc"},
               %{operation: {:assign, 9}, lense: ~c"ot"},
               %{operation: {:assign, 5}, lense: ~c"ab"},
               %{operation: :remove, lense: ~c"pc"},
               %{operation: {:assign, 6}, lense: ~c"pc"},
               %{operation: {:assign, 7}, lense: ~c"ot"}
             ]
    end
  end

  describe "part_two/1" do
    test "example input" do
      assert Day15.part_two(@example_input) == 145
    end

    test "input" do
      input = File.read!("priv/inputs/day-15.txt")
      assert Day15.part_two(input) == 200_277
    end
  end
end
