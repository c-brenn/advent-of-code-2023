defmodule Advent.Day12 do
  defmodule Parser do
    def condition_records(text) do
      text
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [record, checksum] = String.split(line, " ", parts: 2, trim: true)

        groups =
          checksum
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)

        %{record: String.to_charlist(record), groups: groups}
      end)
    end
  end

  def part_one(text) do
    text
    |> Parser.condition_records()
    |> Enum.map(&memoized_count/1)
    |> Enum.sum()
  end

  def part_two(text) do
    text
    |> Parser.condition_records()
    |> Enum.map(fn %{record: record, groups: groups} ->
      %{
        record: Enum.concat([record, [??], record, [??], record, [??], record, [??], record]),
        groups: Enum.concat([groups, groups, groups, groups, groups])
      }
    end)
    |> Enum.map(&memoized_count/1)
    |> Enum.sum()
  end

  defp memoized_count(%{record: record, groups: groups}) do
    {_, count} = memoized_count(record, [0 | groups], %{})
    count
  end

  defp memoized_count([], [], cache) do
    {cache, 1}
  end

  defp memoized_count([], [0], cache) do
    {cache, 1}
  end

  defp memoized_count([?#], [1], cache) do
    {cache, 1}
  end

  defp memoized_count([], [_ | _], cache) do
    {cache, 0}
  end

  defp memoized_count([?# | _], [], cache) do
    {cache, 0}
  end

  defp memoized_count([?#, ?# | _], [1 | _], cache) do
    {cache, 0}
  end

  defp memoized_count([?. | _], [g | _], cache) when g > 0 do
    {cache, 0}
  end

  defp memoized_count(record, groups, cache) do
    cache_key = {record, groups}

    case Map.get(cache, {record, groups}) do
      count when is_number(count) ->
        {cache, count}

      nil ->
        {cache, count} =
          case {record, groups} do
            {[?. | rs], [0 | _] = gs} ->
              memoized_count(rs, gs, cache)

            {[_ | rs], []} ->
              memoized_count(rs, [], cache)

            {[?# | _] = rs, [0 | gs]} ->
              memoized_count(rs, gs, cache)

            {[?#, ?. | rs], [1 | gs]} ->
              memoized_count(rs, [0 | gs], cache)

            {[?#, ?? | rs], [1 | gs]} ->
              memoized_count(rs, [0 | gs], cache)

            {[?# | rs], [g | gs]} when g > 0 ->
              memoized_count(rs, [g - 1 | gs], cache)

            {[?? | rs], gs} ->
              {cache1, count1} = memoized_count([?. | rs], gs, cache)
              {cache2, count2} = memoized_count([?# | rs], gs, cache1)
              {cache2, count1 + count2}
          end

        {Map.put(cache, cache_key, count), count}
    end
  end
end
