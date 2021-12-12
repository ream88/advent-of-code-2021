Code.require_file("../advent_of_code_2021.ex")

defmodule Cave do
  def explore(connections, current \\ "start", paths \\ [])

  def explore(_connections, "end", paths) do
    ["end" | paths] |> Enum.reverse() |> List.to_tuple()
  end

  def explore(connections, current, paths) do
    single_small_cave_visited_twice =
      paths
      |> Enum.filter(&downcase?/1)
      |> Enum.frequencies()
      |> Enum.any?(&(elem(&1, 1) == 2))

    if (downcase?(current) and single_small_cave_visited_twice and current in paths) ||
         (current == "start" and "start" in paths) do
      []
    else
      connections
      |> Enum.filter(fn {from, _to} -> from == current end)
      |> case do
        [] ->
          case paths do
            [previous | _] ->
              explore(connections, previous, [current | paths])

            [] ->
              []
          end

        filtered ->
          filtered
          |> Enum.map(fn {from, to} ->
            explore(connections, to, [from | paths])
          end)
      end
    end
    |> List.flatten()
  end

  def downcase?(string) do
    String.downcase(string) == string
  end
end

AdventOfCode2021.stream_input_file()
|> Enum.map(fn line -> line |> String.split("-") |> List.to_tuple() end)
|> Enum.flat_map(fn {from, to} -> [{from, to}, {to, from}] end)
|> Cave.explore()
|> tap(&IO.inspect(length(&1), label: "result"))
