defmodule Advent.Day08 do
  defmodule Parser do
    import NimbleParsec

    allowed_chars = Enum.concat([?A..?Z], [?0..?9])

    node_name = ascii_char(allowed_chars) |> times(3) |> wrap()

    node =
      node_name
      |> ignore(string(" = ("))
      |> concat(node_name)
      |> ignore(string(", "))
      |> concat(node_name)
      |> ignore(string(")\n"))
      |> reduce({:to_node, []})

    nodes = repeat(node) |> reduce({Enum, :into, [%{}]})

    graph =
      repeat(ascii_char([?R, ?L]))
      |> tag(:directions)
      |> ignore(string("\n\n"))
      |> unwrap_and_tag(nodes, :nodes)

    defparsecp(:parse_graph, graph)

    defp to_node([node, left, right]) do
      {node, {left, right}}
    end

    def graph(text) do
      with {:ok, [directions: directions, nodes: nodes], "", _, _, _} <- parse_graph(text) do
        %{directions: directions, nodes: nodes}
      end
    end
  end

  def part_one(text) do
    %{directions: directions, nodes: nodes} = Parser.graph(text)

    count_steps(~c"AAA", nodes, directions, &(&1 == ~c"ZZZ"))
  end

  def part_two(text) do
    %{directions: directions, nodes: nodes} = Parser.graph(text)

    predicate = &ends_with?(&1, ?Z)

    nodes
    |> Map.keys()
    |> Enum.filter(&ends_with?(&1, ?A))
    |> Enum.map(&count_steps(&1, nodes, directions, predicate))
    |> Enum.reduce(&lowest_common_multiple/2)
  end

  defp count_steps(node, nodes, directions, finished_predicate) do
    directions
    |> Stream.cycle()
    |> Enum.reduce_while({node, 0}, fn direction, {current, steps} ->
      if finished_predicate.(current) do
        {:halt, steps}
      else
        {:cont, {next(nodes, current, direction), steps + 1}}
      end
    end)
  end

  defp next(nodes, node, direction) do
    case {direction, Map.fetch!(nodes, node)} do
      {?L, {l, _r}} -> l
      {?R, {_l, r}} -> r
    end
  end

  defp ends_with?([_, _, x], x), do: true
  defp ends_with?(_, _), do: false

  defp lowest_common_multiple(0, 0), do: 0
  defp lowest_common_multiple(a, b), do: div(a * b, Integer.gcd(a, b))
end
