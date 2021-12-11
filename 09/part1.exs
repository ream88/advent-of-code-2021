Code.require_file("../advent_of_code_2021.ex")

map =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line -> line |> String.codepoints() |> Enum.map(&String.to_integer/1) end)
  |> Enum.with_index()
  |> Enum.flat_map(fn {row, y} ->
    row |> Enum.with_index() |> Enum.map(fn {point, x} -> {{x, y}, point} end)
  end)
  |> Map.new()

is_low_point? = fn {x, y} ->
  point = Map.get(map, {x, y})
  north = Map.get(map, {x, y - 1})
  east = Map.get(map, {x + 1, y})
  south = Map.get(map, {x, y + 1})
  west = Map.get(map, {x - 1, y})

  (is_nil(north) || north > point) and
    (is_nil(east) || east > point) and
    (is_nil(south) || south > point) and
    (is_nil(west) || west > point)
end

map
|> Enum.reduce(0, fn {{x, y}, point}, sum ->
  if is_low_point?.({x, y}) do
    sum + point + 1
  else
    sum
  end
end)
|> IO.inspect(label: "result")
