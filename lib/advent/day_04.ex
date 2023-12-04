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

    indices = lookup_table |> Map.keys() |> Enum.sort()

    search_cards(indices, lookup_table, %{})
  end

  defp matches(%Card{winning: winning, given: given}) do
    winning
    |> MapSet.new()
    |> MapSet.intersection(MapSet.new(given))
    |> MapSet.size()
  end

  defp search_cards([], _table, copies) do
    copies
    |> Map.values()
    |> Enum.sum()
  end

  defp search_cards([idx | rest], table, copies) do
    card = Map.fetch!(table, idx)
    matches = matches(card)
    current_card_copies = Map.get(copies, idx, 0) + 1
    end_copy_idx = min(map_size(table) - 1, idx + matches)

    copies =
      idx..end_copy_idx
      |> Enum.reduce(copies, fn i, acc ->
        inc = if i == idx, do: 1, else: current_card_copies
        Map.update(acc, i, inc, &(&1 + inc))
      end)

    search_cards(rest, table, copies)
  end
end
