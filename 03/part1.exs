Code.compile_file("../advent_of_code_2021.ex")

defmodule Day03.Part1 do
  def most_occurring(numbers, position) do
    {zeros, ones} = frequencies(numbers, position)
    if zeros > ones, do: 0, else: 1
  end

  def least_occurring(numbers, position) do
    {zeros, ones} = frequencies(numbers, position)
    if zeros < ones, do: 0, else: 1
  end

  defp frequencies(numbers, position) do
    numbers
    |> Enum.map(&Enum.at(&1, position))
    |> Enum.frequencies()
    |> Map.values()
    |> List.to_tuple()
  end
end

numbers =
  AdventOfCode2021.stream_input_file()
  |> Stream.map(fn line ->
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end)

length =
  numbers
  |> Enum.at(0)
  |> length()

gamma =
  0..(length - 1)
  |> Enum.map(&Day03.Part1.most_occurring(numbers, &1))
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "gamma")

epsilon =
  0..(length - 1)
  |> Enum.map(&Day03.Part1.least_occurring(numbers, &1))
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "epsilon")

(gamma * epsilon) |> IO.inspect(label: "result")
