defmodule Advent.DayTwo do
  @type cubes() :: %{red: integer(), green: integer(), blue: integer()}

  @spec part_one(String.t(), cubes()) :: integer()
  def part_one(games, cubes) do
    games
    |> String.split("\n", trim: true)
    |> Enum.map(&max_by_colour/1)
    |> Enum.with_index(1)
    |> Enum.filter(fn {maxes, _index} ->
      maxes[:red] <= cubes[:red] and maxes[:green] <= cubes[:green] and
        maxes[:blue] <= cubes[:blue]
    end)
    |> Enum.map(fn {_maxes, index} -> index end)
    |> Enum.sum()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(games) do
    games
    |> String.split("\n", trim: true)
    |> Enum.map(&cube_power/1)
    |> Enum.sum()
  end

  @spec cube_power(String.t()) :: integer()
  def cube_power(game) do
    %{red: red, green: green, blue: blue} = max_by_colour(game)
    red * green * blue
  end

  @spec max_by_colour(String.t()) :: cubes()
  def max_by_colour(game) do
    [_game_prefix, game_results] = String.split(game, ":", parts: 2)

    game_results
    |> String.split(";", trim: true)
    |> Enum.flat_map(&parse_colours/1)
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn {colour, occurrences}, acc ->
      if occurrences > acc[colour] do
        Map.put(acc, colour, occurrences)
      else
        acc
      end
    end)
  end

  defp parse_colours(colours) do
    colours
    |> String.split(",", trim: true)
    |> Enum.map(&parse_colour/1)
  end

  defp parse_colour(text) do
    regex = ~r/(?<occurrences>\d+) (?<colour>[a-z]+)/
    %{"occurrences" => occurrences, "colour" => colour} = Regex.named_captures(regex, text)

    {String.to_atom(colour), String.to_integer(occurrences)}
  end
end
