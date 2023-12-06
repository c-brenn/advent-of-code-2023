defmodule Advent.Day06 do
  defmodule Parser do
    import NimbleParsec

    result_list =
      wrap(
        repeat(
          repeat(ascii_char([?\s]))
          |> ignore()
          |> integer(min: 1, max: 10)
        )
      )

    timesheet =
      string("Time:")
      |> ignore()
      |> concat(result_list)
      |> ignore(ascii_char([?\n]))
      |> ignore(string("Distance:"))
      |> concat(result_list)
      |> ignore(ascii_char([?\n]))
      |> reduce({Enum, :zip, []})

    defparsecp(:timesheet, timesheet)

    def race_records(text) do
      with {:ok, [records], "", _, _, _} <- timesheet(text) do
        records
      end
    end
  end

  @spec part_one(String.t()) :: integer()
  def part_one(text) do
    text
    |> Parser.race_records()
    |> Enum.map(&count_winning_strategies/1)
    |> IO.inspect()
    |> Enum.reduce(1, &(&1 * &2))
  end

  @spec part_two(String.t()) :: integer()
  def part_two(text) do
    {time_parts, distance_parts} =
      text
      |> Parser.race_records()
      |> Enum.unzip()

    time = combine_parts(time_parts)
    distance = combine_parts(distance_parts)

    count_winning_strategies({time, distance})
  end

  defp count_winning_strategies({time_ms, distance_mm}) do
    # solve quadratic in the form
    #  ax^2 + bx + c <= 0
    # where a = 1, b = -time_ms and c = distance_mm + 1
    # x = 0.5 * (-b +- sqrt(b^2 -4ac))
    a = 1
    b = -time_ms
    c = distance_mm
    negatable = :math.sqrt(b * b - 4 * a * c)

    x1 = (0.5 * (-b + negatable)) |> :math.ceil()
    x2 = (0.5 * (-b - negatable)) |> :math.ceil()

    max = max(x1, x2)
    min = min(x1, x2)

    min =
      if min * (time_ms - min) == distance_mm do
        min + 1
      else
        min
      end

    max - min
  end

  defp combine_parts(numbers) do
    numbers
    |> Enum.flat_map(&Integer.digits/1)
    |> Integer.undigits()
  end
end
