defmodule Advent.Day10 do
  defmodule Parser do
    def grid(text) do
      text
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.flat_map(fn
          {?S, x} ->
            [{?S, {y, x}}, {{y, x}, ?S}]

          {char, x} ->
            [{{y, x}, char}]
        end)
      end)
      |> Enum.into(%{})
      |> Map.pop(?S)
    end
  end

  def part_one(text) do
    {start_coords, grid} = Parser.grid(text)

    grid
    |> pipeline_length(start_coords)
    |> div(2)
  end

  def part_two(text) do
    {start_coords, grid} = Parser.grid(text)

    grid
    |> mark_pipeline(start_coords)
    |> count_enclosed()
  end

  def mark_pipeline(grid, start_coords) do
    {next, dir} = first_step(grid, start_coords)
    acc = Map.put(grid, start_coords, {:pipe, ?S})

    mark_pipeline(grid, next, dir, acc)
  end

  def mark_pipeline(grid, coord, dir, acc) do
    case next_pipe(grid, coord, dir) do
      {?S, {y, x}, _} ->
        pipe = replace_animal(grid, {y, x})
        Map.put(acc, {y, x}, {:pipe, pipe})

      {_, next_coord, next_dir} ->
        acc = Map.update!(acc, coord, fn x -> {:pipe, x} end)
        mark_pipeline(grid, next_coord, next_dir, acc)
    end
  end

  defp count_enclosed(grid) do
    {max_y, max_x} =
      grid
      |> Map.keys()
      |> Enum.max()

    0..max_y
    |> Enum.reduce(0, fn y, acc ->
      0..max_x
      |> Enum.reduce({acc, false}, fn x, {count, enclosed?} ->
        case {Map.get(grid, {y, x}), enclosed?} do
          {{:pipe, p}, _} when p in [?|, ?L, ?J] ->
            {count, !enclosed?}

          {{:pipe, _}, _} ->
            {count, enclosed?}

          {_, true} ->
            {count + 1, enclosed?}

          {_, false} ->
            {count, enclosed?}
        end
      end)
      |> then(fn {count, _} -> count end)
    end)
  end

  defp first_step(grid, {y, x}) do
    case neighbours(grid, {y, x}) do
      [char, _, _, _] when char in [?-, ?F, ?L] ->
        {{y, x - 1}, :left}

      [_, char, _, _] when char in [?|, ?F] ->
        {{y - 1, x}, :up}

      [_, _, char, _] when char in [?-, ?7, ?J] ->
        {{y, x + 1}, :right}

      [_, _, _, char] when char in [?|, ?J] ->
        {{y + 1, x}, :down}
    end
  end

  defp neighbours(grid, {y, x}) do
    [
      Map.get(grid, {y, x - 1}),
      Map.get(grid, {y - 1, x}),
      Map.get(grid, {y, x + 1}),
      Map.get(grid, {y + 1, x})
    ]
  end

  defp pipeline_length(grid, start_coords) do
    {coord, dir} = first_step(grid, start_coords)

    pipeline_length(grid, coord, dir, 1)
  end

  defp pipeline_length(grid, coord, direction, acc) do
    case next_pipe(grid, coord, direction) do
      {?S, _, _} ->
        acc

      {_, next_coord, next_direction} ->
        pipeline_length(grid, next_coord, next_direction, acc + 1)
    end
  end

  defp next_pipe(grid, {y, x}, direction) do
    tile = Map.get(grid, {y, x})

    {next_coord, next_direction} =
      case {tile, direction} do
        {?S, _} ->
          {{y, x}, direction}

        {?-, :left} ->
          {{y, x - 1}, :left}

        {?-, :right} ->
          {{y, x + 1}, :right}

        {?|, :up} ->
          {{y - 1, x}, :up}

        {?|, :down} ->
          {{y + 1, x}, :down}

        {?F, :up} ->
          {{y, x + 1}, :right}

        {?F, :left} ->
          {{y + 1, x}, :down}

        {?7, :right} ->
          {{y + 1, x}, :down}

        {?7, :up} ->
          {{y, x - 1}, :left}

        {?J, :right} ->
          {{y - 1, x}, :up}

        {?J, :down} ->
          {{y, x - 1}, :left}

        {?L, :left} ->
          {{y - 1, x}, :up}

        {?L, :down} ->
          {{y, x + 1}, :right}
      end

    {tile, next_coord, next_direction}
  end

  defp replace_animal(grid, coord) do
    case neighbours(grid, coord) do
      [left, _, right, _] when left in [?-, ?F, ?L] and right in [?-, ?J, ?7] ->
        ?-

      [left, top, _, _] when left in [?-, ?F, ?L] and top in [?|, ?F, ?7] ->
        ?J

      [left, _, _, bottom] when left in [?-, ?F, ?L] and bottom in [?|, ?L, ?J] ->
        ?7

      [_, top, _, bottom] when top in [?|, ?F, ?7] and bottom in [?|, ?L, ?J] ->
        ?|

      [_, top, right, _] when top in [?|, ?F, ?7] and right in [?-, ?J, ?7] ->
        ?L

      [_, _, right, bottom] when right in [?-, ?J, ?7] and bottom in [?|, ?L, ?J] ->
        ?F
    end
  end
end
