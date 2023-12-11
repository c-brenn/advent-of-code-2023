defmodule Advent.Day10Test do
  use ExUnit.Case, async: true

  alias Advent.Day10

  describe "Parser.grid/1" do
    test "example input" do
      input = """
      .....
      .F-7.
      .|.|.
      .L-J.
      .....
      """

      assert Day10.Parser.grid(input) ==
               {nil,
                %{
                  {0, 0} => ?.,
                  {0, 1} => ?.,
                  {0, 2} => ?.,
                  {0, 3} => ?.,
                  {0, 4} => ?.,
                  {1, 0} => ?.,
                  {1, 1} => ?F,
                  {1, 2} => ?-,
                  {1, 3} => ?7,
                  {1, 4} => ?.,
                  {2, 0} => ?.,
                  {2, 1} => ?|,
                  {2, 2} => ?.,
                  {2, 3} => ?|,
                  {2, 4} => ?.,
                  {3, 0} => ?.,
                  {3, 1} => ?L,
                  {3, 2} => ?-,
                  {3, 3} => ?J,
                  {3, 4} => ?.,
                  {4, 0} => ?.,
                  {4, 1} => ?.,
                  {4, 2} => ?.,
                  {4, 3} => ?.,
                  {4, 4} => ?.
                }}
    end

    test "with animal" do
      input = """
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
      """

      assert Day10.Parser.grid(input) ==
               {{1, 1},
                %{
                  {0, 0} => ?.,
                  {0, 1} => ?.,
                  {0, 2} => ?.,
                  {0, 3} => ?.,
                  {0, 4} => ?.,
                  {1, 0} => ?.,
                  {1, 1} => ?S,
                  {1, 2} => ?-,
                  {1, 3} => ?7,
                  {1, 4} => ?.,
                  {2, 0} => ?.,
                  {2, 1} => ?|,
                  {2, 2} => ?.,
                  {2, 3} => ?|,
                  {2, 4} => ?.,
                  {3, 0} => ?.,
                  {3, 1} => ?L,
                  {3, 2} => ?-,
                  {3, 3} => ?J,
                  {3, 4} => ?.,
                  {4, 0} => ?.,
                  {4, 1} => ?.,
                  {4, 2} => ?.,
                  {4, 3} => ?.,
                  {4, 4} => ?.
                }}
    end
  end

  describe "part_one/1" do
    test "example input" do
      input = """
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
      """

      assert Day10.part_one(input) == 4

      input = """
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
      """

      assert Day10.part_one(input) == 8
    end

    test "input" do
      input = File.read!("priv/inputs/day-10.txt")

      assert Day10.part_one(input) == 7005
    end
  end

  describe "mark_pipeline/2" do
    test "example input" do
      input = """
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
      """

      {start_coords, grid} = Day10.Parser.grid(input)

      assert Day10.mark_pipeline(grid, start_coords) ==
               %{
                 {0, 0} => ?.,
                 {0, 1} => ?.,
                 {0, 2} => ?.,
                 {0, 3} => ?.,
                 {0, 4} => ?.,
                 {1, 0} => ?.,
                 {1, 1} => {:pipe, ?F},
                 {1, 2} => {:pipe, ?-},
                 {1, 3} => {:pipe, ?7},
                 {1, 4} => ?.,
                 {2, 0} => ?.,
                 {2, 1} => {:pipe, ?|},
                 {2, 2} => ?.,
                 {2, 3} => {:pipe, ?|},
                 {2, 4} => ?.,
                 {3, 0} => ?.,
                 {3, 1} => {:pipe, ?L},
                 {3, 2} => {:pipe, ?-},
                 {3, 3} => {:pipe, ?J},
                 {3, 4} => ?.,
                 {4, 0} => ?.,
                 {4, 1} => ?.,
                 {4, 2} => ?.,
                 {4, 3} => ?.,
                 {4, 4} => ?.
               }
    end
  end

  describe "part_two/1" do
    test "example input" do
      input = """
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........\
      """

      assert Day10.part_two(input) == 4

      input = """
      ..........
      .S------7.
      .|F----7|.
      .||....||.
      .||....||.
      .|L-7F-J|.
      .|..||..|.
      .L--JL--J.
      ..........\
      """

      assert Day10.part_two(input) == 4

      input = """
      .F----7F7F7F7F-7....
      .|F--7||||||||FJ....
      .||.FJ||||||||L7....
      FJL7L7LJLJ||LJ.L-7..
      L--J.L7...LJS7F-7L7.
      ....F-J..F7FJ|L7L7L7
      ....L7.F7||L7|.L7L7|
      .....|FJLJ|FJ|F7|.LJ
      ....FJL-7.||.||||...
      ....L---J.LJ.LJLJ...\
      """

      assert Day10.part_two(input) == 8

      input = """
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L\
      """

      assert Day10.part_two(input) == 10
    end

    test "input" do
      input = File.read!("priv/inputs/day-10.txt")
      assert Day10.part_two(input) == 417
    end
  end
end
