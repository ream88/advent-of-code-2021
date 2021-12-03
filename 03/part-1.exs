Code.compile_file("../advent_of_code_2021.ex")

defmodule Day03.Part1 do
  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end

frequencies =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line ->
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end)
  |> Day03.Part1.transpose()
  |> Enum.map(&Enum.frequencies(&1))

gamma =
  frequencies
  |> Enum.map(fn column -> column |> Enum.max_by(&elem(&1, 1)) |> elem(0) end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "gamma")

epsilon =
  frequencies
  |> Enum.map(fn column -> column |> Enum.min_by(&elem(&1, 1)) |> elem(0) end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "epsilon")

(gamma * epsilon) |> IO.inspect(label: "result")
