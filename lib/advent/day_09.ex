defmodule Advent.Day09 do
  defmodule Parser do
    def readings(text) do
      text
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" ", trim: true)
        |> Enum.map(fn str ->
          {x, ""} = Integer.parse(str)
          x
        end)
      end)
    end
  end

  def part_one(text) do
    text
    |> Parser.readings()
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&next_value/1)
    |> Enum.sum()
  end

  def part_two(text) do
    text
    |> Parser.readings()
    |> Enum.map(&next_value/1)
    |> Enum.sum()
  end

  defp next_value([h | _] = readings) do
    next_value(readings, h)
  end

  defp next_value(current, acc) do
    if Enum.any?(current, &(&1 != 0)) do
      next =
        current
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(fn [x, y] -> x - y end)

      next_value(next, acc + hd(next))
    else
      acc
    end
  end
end
