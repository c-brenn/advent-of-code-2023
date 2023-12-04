defmodule Advent.Day03 do
  defmodule Parser do
    import NimbleParsec

    part_number =
      integer(min: 1, max: 3)
      |> post_traverse({:record, [:part_number]})

    symbol =
      ascii_char([{:not, ?\n}])
      |> post_traverse({:record, [:symbol]})

    engine_schematic =
      [part_number, symbol]
      |> choice()
      |> repeat()
      |> ignore(ascii_char([?\n]))
      |> repeat()

    defparsec(:engine_schematic, engine_schematic)

    defp record(rest, [value], context, {line, position}, offset, :part_number) do
      length = value |> Integer.digits() |> Enum.count()
      start_x = offset - position - length + 1
      end_x = offset - position

      start_coord = {line, start_x}

      entries =
        for x <- start_x..end_x do
          coord = {line, x}
          {coord, %{id: start_coord, value: {:part_number, value}}}
        end

      {rest, entries, context}
    end

    defp record(rest, [?.], context, _position, _offset, :symbol) do
      {rest, [], context}
    end

    defp record(rest, [value], context, {line, position}, offset, :symbol) do
      coord = {line, offset - position}
      entry = {coord, %{id: coord, value: {:symbol, value}}}
      {rest, [entry], context}
    end
  end

  @spec matrix(String.t()) :: map()
  def matrix(engine_schematic) do
    {:ok, entries, "", %{}, _, _} = Parser.engine_schematic(engine_schematic)

    Enum.into(entries, %{})
  end

  @spec part_one(String.t()) :: integer()
  def part_one(engine_schematic) do
    matrix = matrix(engine_schematic)

    matrix
    |> Enum.reduce(%{}, fn
      {coord, %{id: id, value: {:part_number, part_number}}}, acc ->
        neighbours = neighbours(matrix, coord)

        if Enum.any?(neighbours, &is_symbol?/1) do
          Map.put(acc, id, part_number)
        else
          acc
        end

      _, acc ->
        acc
    end)
    |> Map.values()
    |> Enum.sum()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(schematic) do
    matrix = matrix(schematic)

    Enum.reduce(matrix, 0, fn
      {coord, %{value: {:symbol, ?*}}}, acc ->
        case neighbours(matrix, coord) do
          [%{value: {:part_number, p1}}, %{value: {:part_number, p2}}] ->
            acc + p1 * p2

          _ ->
            acc
        end

      _, acc ->
        acc
    end)
  end

  defp neighbours(matrix, {y, x}) do
    coords =
      for y1 <- (y - 1)..(y + 1),
          x1 <- (x - 1)..(x + 1),
          y1 != y or x1 != x do
        {y1, x1}
      end

    matrix
    |> Map.take(coords)
    |> Map.values()
    |> Enum.uniq_by(& &1.id)
  end

  defp is_symbol?(%{value: {:symbol, _}}), do: true
  defp is_symbol?(_), do: false
end
