Code.compile_file("../advent_of_code_2021.ex")

defmodule Day03.Part2 do
  def o2(numbers, position) do
    filter(numbers, position, &>=/2)
  end

  def co2(numbers, position) do
    filter(numbers, position, &</2)
  end

  defp filter(numbers, position, fun) do
    {zeros, ones} = frequencies(numbers, position)
    criteria = if fun.(ones, zeros), do: 1, else: 0

    numbers
    |> Enum.filter(&(Enum.at(&1, position) == criteria))
  end

  defp frequencies(numbers, position) do
    numbers
    |> Stream.map(&Enum.at(&1, position))
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

oxygen_generator_rating =
  0..(length - 1)
  |> Enum.reduce_while(numbers, fn position, numbers ->
    case Day03.Part2.o2(numbers, position) do
      [number] -> {:halt, number}
      numbers -> {:cont, numbers}
    end
  end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "oxygen_generator_rating")

co2_scrubber_rating =
  0..(length - 1)
  |> Enum.reduce_while(numbers, fn position, numbers ->
    case Day03.Part2.co2(numbers, position) do
      [number] -> {:halt, number}
      numbers -> {:cont, numbers}
    end
  end)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "co2_scrubber_rating")

(oxygen_generator_rating * co2_scrubber_rating) |> IO.inspect(label: "result")
