defmodule Advent.Day05 do
  defmodule Parser do
    import NimbleParsec

    space_then_int =
      ascii_char([?\s])
      |> ignore()
      |> integer(min: 1, max: 20)

    seeds =
      string("seeds:")
      |> ignore()
      |> repeat(space_then_int)
      |> tag(:seeds)

    new_line = ascii_char([?\n]) |> ignore()

    source_dest_map =
      repeat(
        integer(min: 1, max: 20)
        |> times(space_then_int, 2)
        |> ignore(ascii_char([?\n]))
      )
      |> reduce({:range_map, []})

    make_section = fn prefix, tag ->
      string("#{prefix} map:\n")
      |> ignore()
      |> concat(source_dest_map)
      |> unwrap_and_tag(tag)
    end

    almanac =
      seeds
      |> concat(times(new_line, 2))
      |> concat(make_section.("seed-to-soil", :seed_to_soil))
      |> concat(new_line)
      |> concat(make_section.("soil-to-fertilizer", :soil_to_fertilizer))
      |> concat(new_line)
      |> concat(make_section.("fertilizer-to-water", :fertilizer_to_water))
      |> concat(new_line)
      |> concat(make_section.("water-to-light", :water_to_light))
      |> concat(new_line)
      |> concat(make_section.("light-to-temperature", :light_to_temperature))
      |> concat(new_line)
      |> concat(make_section.("temperature-to-humidity", :temperature_to_humidity))
      |> concat(new_line)
      |> concat(make_section.("humidity-to-location", :humidity_to_location))

    defparsecp(:parse_almanac, almanac)

    def almanac(text) do
      with {:ok, parsed, "", _, _, _} <- parse_almanac(text) do
        Enum.into(parsed, %{})
      end
    end

    defp range_map(list) do
      list
      |> Enum.chunk_every(3)
      |> Enum.map(fn [dest_start, source_start, length] ->
        %{
          dest: {dest_start, dest_start + length - 1},
          source: {source_start, source_start + length - 1}
        }
      end)
    end
  end

  @spec part_one(String.t()) :: integer()
  def part_one(text) do
    almanac = Parser.almanac(text)

    almanac.seeds
    |> Enum.map(&to_location(&1, almanac))
    |> Enum.min()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(text) do
    almanac = Parser.almanac(text)

    almanac.seeds
    |> Enum.chunk_every(2)
    |> Enum.flat_map(fn [first, length] ->
      to_location([{first, length}], almanac)
    end)
    |> Enum.min_by(fn {first, _length} -> first end)
    |> then(fn {first, _length} -> first end)
  end

  defp to_location(seed_or_ranges, almanac) do
    seed_or_ranges
    |> run_step(:seed_to_soil, almanac)
    |> run_step(:soil_to_fertilizer, almanac)
    |> run_step(:fertilizer_to_water, almanac)
    |> run_step(:water_to_light, almanac)
    |> run_step(:light_to_temperature, almanac)
    |> run_step(:temperature_to_humidity, almanac)
    |> run_step(:humidity_to_location, almanac)
  end

  defp run_step(value, step, almanac) when is_number(value) do
    maps = Map.get(almanac, step, [])

    map =
      Enum.find(maps, fn %{source: {s_start, s_end}} -> s_start <= value and value <= s_end end)

    result =
      case map do
        %{source: {s_start, _}, dest: {d_start, _}} ->
          value - s_start + d_start

        nil ->
          value
      end

    result
  end

  defp run_step(ranges, step, almanac) when is_list(ranges) do
    maps = Map.get(almanac, step, [])

    Enum.flat_map(ranges, fn range ->
      split_range(range, maps, [])
    end)
  end

  defp split_range(left_over, [], acc), do: [left_over | acc]

  defp split_range({x, length}, [%{source: {x1, y1}, dest: {x2, _}} | rest], acc) do
    case overlap({x, length}, {x1, y1}) do
      :none ->
        split_range({x, length}, rest, acc)

      :total ->
        [{x2 + x - x1, length} | acc]

      :partial_start ->
        left_over = {y1 + 1, x + length - y1}
        mapped = {x2 + x - x1, y1 - x}
        split_range(left_over, rest, [mapped | acc])

      :partial_end ->
        left_over = {x, x1 - x}
        mapped = {x2, x + length - x1}
        split_range(left_over, rest, [mapped | acc])
    end
  end

  defp overlap({x, length}, {x1, y1}) when x1 <= x and x + length - 1 <= y1, do: :total
  defp overlap({x, _}, {x1, y1}) when x1 <= x and x <= y1, do: :partial_start

  defp overlap({x, length}, {x1, y1}) when x1 <= x + length - 1 and x + length - 1 <= y1,
    do: :partial_end

  defp overlap(_, _), do: :none
end
