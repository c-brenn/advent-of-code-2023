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
    |> tilt()
    |> count_load()
  end

  @cycles 1_000_000_000

  def part_two(text) do
    {cycle_start, cycle_end, state_cache} =
      text
      |> Parser.columns()
      |> find_cycle()

    cycle_period = cycle_end - cycle_start

    offset = rem(@cycles - cycle_end, cycle_period)
    end_index = cycle_start + offset
    {state, _} = Enum.find(state_cache, fn {_k, v} -> v == end_index end)

    count_load(state)
  end

  def transpose(grid) do
    grid
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def tilt(columns, sort_dir \\ :asc) do
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
          sort_dir
        )
      end)
      |> Enum.concat()
    end)
  end

  def cycle(grid) do
    [:asc, :asc, :desc, :desc]
    |> Enum.reduce(grid, fn sort_dir, acc ->
      acc
      |> tilt(sort_dir)
      |> transpose()
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

  defp find_cycle(grid) do
    find_cycle(grid, 0, %{grid => 0})
  end

  defp find_cycle(grid, cycle, cache) do
    grid = cycle(grid)
    cycle = cycle + 1

    if index = Map.get(cache, grid) do
      {index, cycle, cache}
    else
      find_cycle(grid, cycle, Map.put(cache, grid, cycle))
    end
  end
end
