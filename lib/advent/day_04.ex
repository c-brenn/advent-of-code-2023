defmodule Advent.Day04 do
  defmodule Card do
    defstruct [:winning, :given]

    @type t() :: %__MODULE__{winning: [integer()], given: [integer()]}

    @spec parse!(String.t()) :: t()
    def parse!(text) do
      [_, rest] = String.split(text, ":", parts: 2)
      [winning_str, given_str] = String.split(rest, "|", parts: 2)

      parse_ints = fn str ->
        str
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end

      %__MODULE__{
        winning: parse_ints.(winning_str),
        given: parse_ints.(given_str)
      }
    end
  end

  @spec to_cards(String.t()) :: [Card.t()]
  def to_cards(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(&Card.parse!/1)
  end

  @spec part_one(String.t()) :: integer()
  def part_one(text) do
    text
    |> to_cards()
    |> Enum.reduce(0, fn card, acc ->
      matches = matches(card)

      if matches > 0 do
        acc + Integer.pow(2, matches - 1)
      else
        acc
      end
    end)
  end

  @spec part_two(String.t()) :: integer()
  def part_two(text) do
    lookup_table =
      text
      |> to_cards()
      |> Enum.with_index()
      |> Enum.into(%{}, fn {v, k} -> {k, v} end)

    search_cards(Map.to_list(lookup_table), 0, lookup_table)
  end

  defp matches(%Card{winning: winning, given: given}) do
    winning
    |> MapSet.new()
    |> MapSet.intersection(MapSet.new(given))
    |> MapSet.size()
  end

  defp search_cards([], count, _table), do: count

  defp search_cards([{idx, card} | rest], count, table) do
    matches = matches(card)

    if matches == 0 do
      search_cards(rest, count + 1, table)
    else
      indices =
        (idx + 1)..(idx + matches)
        |> Range.to_list()

      new_cards =
        Map.take(table, indices)
        |> Map.to_list()

      search_cards(new_cards ++ rest, count + 1, table)
    end
  end
end
