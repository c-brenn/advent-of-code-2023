defmodule Advent.Day11 do
  defmodule Parser do
    def image(text) do
      acc = %{
        galaxies: [],
        non_empty_rows: MapSet.new([]),
        non_empty_columns: MapSet.new([])
      }

      text
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {row, y}, acc ->
        row
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {c, x}, acc ->
          case c do
            ?# ->
              acc
              |> Map.update!(:non_empty_rows, &MapSet.put(&1, y))
              |> Map.update!(:non_empty_columns, &MapSet.put(&1, x))
              |> Map.update!(:galaxies, &[{y, x} | &1])

            _ ->
              acc
          end
        end)
      end)
    end
  end

  def expand(
        %{
          galaxies: galaxies,
          non_empty_rows: non_empty_rows,
          non_empty_columns: non_empty_columns
        },
        factor
      ) do
    Enum.map(galaxies, fn {y, x} ->
      added_rows = Enum.count(0..y, &(not MapSet.member?(non_empty_rows, &1)))
      added_columns = Enum.count(0..x, &(not MapSet.member?(non_empty_columns, &1)))

      {y + added_rows * (factor - 1), x + added_columns * (factor - 1)}
    end)
  end

  def part_one(text) do
    part_two(text, factor: 2)
  end

  def part_two(text, opts \\ []) do
    factor = Keyword.get(opts, :factor, 1_000_000)

    galaxies =
      text
      |> Parser.image()
      |> expand(factor)

    pairs = for g1 <- galaxies, g2 <- galaxies, do: Enum.sort([g1, g2])
    pairs = Enum.uniq(pairs)

    pairs
    |> Enum.map(&distance/1)
    |> Enum.sum()
  end

  defp distance([{y1, x1}, {y2, x2}]) do
    abs(y2 - y1) + abs(x2 - x1)
  end
end
