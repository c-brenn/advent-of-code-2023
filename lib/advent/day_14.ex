defmodule Advent.Day14 do
  defmodule Parser do
    def columns(text) do
      text
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
    end
  end

  def part_one(text) do
    text
    |> Parser.columns()
    |> tilt_north()
    |> count_load()
  end

  def tilt_north(columns) do
    columns
    |> Enum.map(fn column ->
      column
      |> Enum.chunk_by(&(&1 == ?#))
      |> Enum.map(fn chunk ->
        Enum.sort_by(
          chunk,
          fn
            ?O -> 1
            ?. -> 2
            ?# -> 4
          end,
          :asc
        )
      end)
      |> Enum.concat()
    end)
  end

  defp count_load([first_column | _] = sorted_columns) do
    offset = Enum.count(first_column) + 1

    sorted_columns
    |> Enum.reduce(0, fn column, acc ->
      column_load =
        column
        |> Enum.with_index(1)
        |> Enum.filter(fn {char, _i} -> char == ?O end)
        |> Enum.map(fn {_char, i} -> offset - i end)
        |> Enum.sum()

      acc + column_load
    end)
  end
end
