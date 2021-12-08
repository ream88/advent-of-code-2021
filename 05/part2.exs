Code.require_file("../advent_of_code_2021.ex")

defmodule Day05.Part2 do
  def draw(field, line) do
    case line do
      [x, y1, x, y2] -> Enum.zip(Stream.cycle([x]), y1..y2)
      [x1, y, x2, y] -> Enum.zip(x1..x2, Stream.cycle([y]))
      [x1, y1, x2, y2] -> Enum.zip(x1..x2, y1..y2)
    end
    |> Enum.reduce(field, fn {x, y}, field ->
      List.update_at(field, y, fn row ->
        List.update_at(row, x, &(&1 + 1))
      end)
    end)
  end

  def inspect(field) do
    Enum.each(field, fn row ->
      Enum.each(row, fn
        0 -> IO.write(".")
        value -> IO.write(value)
      end)

      IO.puts("")
    end)

    field
  end
end

regex = ~r/(\d+),(\d+)\s->\s(\d+),(\d+)/

lines =
  AdventOfCode2021.stream_input_file()
  |> Stream.map(fn line ->
    Regex.run(regex, line, capture: :all_but_first)
    |> Enum.map(&String.to_integer/1)
  end)

width =
  lines
  |> Enum.flat_map(fn [x1, _, x2, _] -> [x1, x2] end)
  |> Enum.max()

height =
  lines
  |> Enum.flat_map(fn [_, y1, _, y2] -> [y1, y2] end)
  |> Enum.max()

field =
  for _ <- 0..width do
    for _ <- 0..height do
      0
    end
  end

lines
|> Enum.reduce(field, fn line, field ->
  Day05.Part2.draw(field, line)
end)
|> List.flatten()
|> Enum.count(&(&1 >= 2))
|> IO.inspect(label: "result")
