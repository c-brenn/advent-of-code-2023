defmodule Advent.DayOne do
  @spec sum_calibration_document(String.t(), Keyword.t()) :: integer()
  def sum_calibration_document(document, opts \\ []) do
    document
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value(&1, opts))
    |> Enum.sum()
  end

  @spec calibration_value(String.t(), Keyword.t()) :: integer()
  def calibration_value(text, opts \\ []) do
    include_words? = Keyword.get(opts, :include_words?, true)

    first = find_digit(text, include_words?, :forward)
    last = text |> String.reverse() |> find_digit(include_words?, :reversed)

    first * 10 + last
  end

  for {value, word} <- [
        {0, "zero"},
        {1, "one"},
        {2, "two"},
        {3, "three"},
        {4, "four"},
        {5, "five"},
        {6, "six"},
        {7, "seven"},
        {8, "eight"},
        {9, "nine"}
      ] do
    digit = to_string(value)
    reversed_word = String.reverse(word)

    defp find_digit(<<unquote(digit), _::binary>>, _include_words?, _direction),
      do: unquote(value)

    defp find_digit(<<unquote(word), _::binary>>, true, :forward), do: unquote(value)
    defp find_digit(<<unquote(reversed_word), _::binary>>, true, :reversed), do: unquote(value)
  end

  defp find_digit(<<_::binary-size(1), rest::binary>>, include_words?, direction) do
    find_digit(rest, include_words?, direction)
  end
end
