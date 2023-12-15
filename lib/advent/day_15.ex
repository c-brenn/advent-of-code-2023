defmodule Advent.Day15 do
  defmodule Parser do
    import NimbleParsec

    lense =
      ascii_char([?a..?z])
      |> times(min: 1, max: 10)
      |> tag(:lense)

    assign =
      ascii_char([?=])
      |> ignore()
      |> integer(min: 1, max: 10)
      |> unwrap_and_tag(:assign)

    remove =
      ascii_char([?-])
      |> tag(:remove)

    operation = lense |> choice([assign, remove])

    defparsecp(:parse_operation, operation)

    def operation(text) do
      case parse_operation(text) do
        {:ok, [lense: l, assign: v], "", _, _, _} ->
          %{lense: l, operation: {:assign, v}}

        {:ok, [lense: l, remove: _], "", _, _, _} ->
          %{lense: l, operation: :remove}
      end
    end
  end

  def part_one(text) do
    text
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  def part_two(text) do
    text
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, &update_boxes/2)
    |> Enum.reduce(0, &sum_boxes/2)
  end

  def hash(str) when is_binary(str) do
    str
    |> String.to_charlist()
    |> hash()
  end

  def hash(chars) when is_list(chars) do
    Enum.reduce(chars, 0, fn char, acc ->
      rem((acc + char) * 17, 256)
    end)
  end

  defp update_boxes({operation, index}, boxes) do
    %{lense: l, operation: op} = Parser.operation(operation)
    box = hash(l)

    case op do
      {:assign, v} ->
        Map.update(boxes, box, %{l => {v, index}}, fn b ->
          Map.update(b, l, {v, index}, fn {_v0, existing_index} -> {v, existing_index} end)
        end)

      :remove ->
        Map.update(boxes, box, %{}, &Map.delete(&1, l))
    end
  end

  defp sum_boxes({box, lenses}, acc) do
    lenses
    |> Enum.sort_by(fn {_l, {_v, index}} -> index end, :asc)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, {focal_length, _}}, slot} -> (box + 1) * slot * focal_length end)
    |> Enum.sum()
    |> Kernel.+(acc)
  end
end
