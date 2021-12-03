Code.compile_file("../advent_of_code_2021.ex")

defmodule Day03.Part1 do
  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end

most_common =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line ->
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end)
  |> Day03.Part1.transpose()
  |> Enum.map(fn line ->
    line
    |> Enum.reduce({0, 0}, fn
      0, {zeros, ones} -> {zeros + 1, ones}
      1, {zeros, ones} -> {zeros, ones + 1}
    end)
  end)

gamma =
  most_common
  |> Enum.map(fn {zeros, ones} ->
    if zeros > ones, do: 0, else: 1
  end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "gamma")

epsilon =
  most_common
  |> Enum.map(fn {zeros, ones} ->
    if zeros > ones, do: 1, else: 0
  end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "epsilon")

(gamma * epsilon) |> IO.inspect(label: "result")
