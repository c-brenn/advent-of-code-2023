defmodule Advent.Day07 do
  defmodule Parser do
    import NimbleParsec

    card = ascii_char([?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?T, ?J, ?Q, ?K, ?A])

    hand =
      card
      |> times(5)
      |> tag(:hand)

    bid = integer(min: 1, max: 10) |> unwrap_and_tag(:bid)

    round =
      repeat(
        hand
        |> ignore(ascii_char([?\s]))
        |> concat(bid)
        |> ignore(ascii_char([?\n]))
      )

    defparsecp(:parse_round, round)

    def round(text) do
      with {:ok, camel_cards, "", _, _, _} <- parse_round(text) do
        camel_cards
        |> Enum.chunk_every(2)
        |> Enum.map(&Enum.into(&1, %{}))
      end
    end
  end

  def part_one(text) do
    run_round(text, jokers?: false)
  end

  def part_two(text) do
    run_round(text, jokers?: true)
  end

  defp run_round(round, opts) do
    round
    |> Parser.round()
    |> Enum.sort_by(
      fn %{hand: cards} ->
        {hand_rank(cards, opts), Enum.map(cards, &rank_card(&1, opts))}
      end,
      :asc
    )
    |> Enum.with_index(1)
    |> Enum.map(fn {%{bid: bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  defp hand_rank(cards, opts) do
    cards
    |> count_cards(opts)
    |> categorize_hand()
    |> rank_hand()
  end

  cards = [?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?T, ?J, ?Q, ?K, ?A]

  defp rank_card(?J, jokers?: true), do: 0

  for {card, rank} <- Enum.with_index(cards, 2) do
    defp rank_card(unquote(card), _), do: unquote(rank)
  end

  hand_types = [
    :high_card,
    :pair,
    :two_pair,
    :three_of_a_kind,
    :full_house,
    :four_of_a_kind,
    :five_of_a_kind
  ]

  for {hand_type, rank} <- Enum.with_index(hand_types) do
    defp rank_hand(unquote(hand_type)), do: unquote(rank)
  end

  defp count_cards(cards, opts) do
    cards
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_k, v} -> v end, :desc)
    |> then(fn c ->
      if Keyword.get(opts, :jokers?, false) do
        merge_jokers(c)
      else
        c
      end
    end)
  end

  defp categorize_hand(counted_cards) do
    case counted_cards do
      [{_, 5}] -> :five_of_a_kind
      [{_, 4} | _] -> :four_of_a_kind
      [{_, 3}, {_, 2}] -> :full_house
      [{_, 3} | _] -> :three_of_a_kind
      [{_, 2}, {_, 2} | _] -> :two_pair
      [{_, 2} | _] -> :pair
      _ -> :high_card
    end
  end

  defp merge_jokers(cards) do
    case Enum.split_with(cards, fn {card, _} -> card == ?J end) do
      {[], _} ->
        cards

      {[{?J, 5}], _} ->
        cards

      {[{?J, j_count}], [{best, count} | rest]} ->
        [{best, count + j_count} | rest]
    end
  end
end
