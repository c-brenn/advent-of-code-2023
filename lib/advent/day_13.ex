defmodule Advent.Day13 do
  defmodule Parser do
    def grids(text) do
      text
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn grid ->
        grid
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_charlist/1)
        |> from_charlists()
      end)
    end

    def from_charlists(charlists) do
      charlists
      |> Enum.with_index(1)
      |> Enum.flat_map(fn {line, y} ->
        line
        |> Enum.with_index(1)
        |> Enum.map(fn {char, x} ->
          {{y, x}, char}
        end)
      end)
      |> Enum.into(%{})
    end
  end

  def part_one(text), do: solve(text, 0)

  def part_two(text), do: solve(text, 1)

  def transpose(grid) do
    {max_y, max_x} = grid |> Map.keys() |> Enum.max()

    Enum.map(1..max_y, fn y ->
      Enum.map(1..max_x, &Map.get(grid, {y, &1}))
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Parser.from_charlists()
  end

  def solve(text, target_smudges) do
    Parser.grids(text)
    |> Enum.map(fn grid ->
      horizontal = find_mirror(grid, target_smudges)
      vertical = grid |> transpose() |> find_mirror(target_smudges)

      horizontal + 100 * vertical
    end)
    |> Enum.sum()
  end

  defp find_mirror(grid, target_smudges) do
    {max_y, max_x} = grid |> Map.keys() |> Enum.max()

    mirrors = 1..(max_x - 1)

    Enum.find(mirrors, 0, fn mirror ->
      possibilities = for y <- 1..max_y, x_offset <- 0..mirror, do: {y, x_offset}

      smudges =
        Enum.reduce_while(possibilities, 0, fn {y, x_offset}, smudges ->
          x1 = mirror - x_offset
          x2 = mirror + x_offset + 1

          inc =
            case {Map.get(grid, {y, x1}), Map.get(grid, {y, x2})} do
              {nil, _} -> 0
              {_, nil} -> 0
              {x, x} -> 0
              _ -> 1
            end

          smudges = smudges + inc

          if smudges > target_smudges do
            {:halt, smudges}
          else
            {:cont, smudges}
          end
        end)

      smudges == target_smudges
    end)
  end
end
