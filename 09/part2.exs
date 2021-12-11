Code.require_file("../advent_of_code_2021.ex")

defmodule Day09.Part2 do
  def is_low_point?(map, {x, y}) do
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

  def find_low_point(map, {x, y}) do
    point = Map.get(map, {x, y})
    north = Map.get(map, {x, y - 1})
    east = Map.get(map, {x + 1, y})
    south = Map.get(map, {x, y + 1})
    west = Map.get(map, {x - 1, y})

    cond do
      Day09.Part2.is_low_point?(map, {x, y}) -> {x, y}
      !is_nil(north) && point > north -> Day09.Part2.find_low_point(map, {x, y - 1})
      !is_nil(east) && point > east -> Day09.Part2.find_low_point(map, {x + 1, y})
      !is_nil(south) && point > south -> Day09.Part2.find_low_point(map, {x, y + 1})
      !is_nil(west) && point > west -> Day09.Part2.find_low_point(map, {x - 1, y})
    end
  end
end

map =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line -> line |> String.codepoints() |> Enum.map(&String.to_integer/1) end)
  |> AdventOfCode2021.to_map()

map
|> Enum.reduce(%{}, fn {{x, y}, point}, acc ->
  if point == 9 do
    acc
  else
    low_point = Day09.Part2.find_low_point(map, {x, y})
    Map.update(acc, low_point, 1, &(&1 + 1))
  end
end)
|> Map.values()
|> Enum.sort(&>=/2)
|> Enum.take(3)
|> Enum.product()
|> IO.inspect(label: "result")
