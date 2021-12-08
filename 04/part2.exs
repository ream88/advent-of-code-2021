Code.require_file("../advent_of_code_2021.ex")
Code.require_file("./bingo.ex")

lines = AdventOfCode2021.stream_input_file()

numbers =
  lines
  |> Enum.at(0)
  |> String.split(",", trim: true)

bingos =
  lines
  |> Stream.drop(1)
  |> Stream.chunk_every(6)
  |> Enum.map(&Enum.join(&1, " "))
  |> Enum.map(&Bingo.new(&1))

{_bingos, won} =
  numbers
  |> Enum.reduce({bingos, []}, fn number, {bingos, won} ->
    {new_won, new_bingos} =
      bingos
      |> Enum.map(&Bingo.mark(&1, number))
      |> Enum.split_with(&Bingo.bingo?(&1))

    {new_bingos, won ++ Enum.map(new_won, &{&1, String.to_integer(number)})}
  end)

{last_bingo, number} = List.last(won)
(number * Bingo.sum(last_bingo)) |> IO.inspect(label: "result")
