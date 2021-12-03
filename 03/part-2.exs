Code.compile_file("../advent_of_code_2021.ex")

defmodule Day03.Part2 do
  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def filter_numbers_with_higher_frequency(numbers, position) do
    frequencies =
      numbers
      |> Day03.Part2.transpose()
      |> Enum.map(&Enum.frequencies(&1))

    criteria =
      frequencies
      |> Enum.map(fn
        %{0 => zeros, 1 => ones} when zeros > ones -> 0
        %{0 => zeros, 1 => ones} when zeros <= ones -> 1
        %{1 => _} -> 1
        %{0 => _} -> 0
      end)

    numbers
    |> Enum.filter(&(Enum.at(&1, position) == Enum.at(criteria, position)))
  end

  def filter_numbers_with_lower_frequency(numbers, position) do
    frequencies =
      numbers
      |> Day03.Part2.transpose()
      |> Enum.map(&Enum.frequencies(&1))

    criteria =
      frequencies
      |> Enum.map(fn
        %{0 => zeros, 1 => ones} when zeros > ones -> 1
        %{0 => zeros, 1 => ones} when zeros <= ones -> 0
        %{1 => _} -> 1
        %{0 => _} -> 0
      end)

    numbers
    |> Enum.filter(&(Enum.at(&1, position) == Enum.at(criteria, position)))
  end
end

numbers =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line ->
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end)

length =
  numbers
  |> Enum.at(0)
  |> length()

oxygen_generator_rating =
  0..length
  |> Enum.reduce(numbers, fn position, numbers ->
    Day03.Part2.filter_numbers_with_higher_frequency(numbers, position)
  end)
  |> Enum.at(0)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "oxygen_generator_rating")

co2_scrubber_rating =
  0..length
  |> Enum.reduce(numbers, fn position, numbers ->
    Day03.Part2.filter_numbers_with_lower_frequency(numbers, position)
  end)
  |> Enum.at(0)
  |> Enum.join()
  |> String.to_integer(2)
  |> IO.inspect(label: "co2_scrubber_rating")

(oxygen_generator_rating * co2_scrubber_rating) |> IO.inspect(label: "result")
