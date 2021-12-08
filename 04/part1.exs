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

{winning_number, sum} =
  numbers
  |> Enum.reduce_while(bingos, fn number, bingos ->
    bingos =
      bingos
      |> Enum.map(&Bingo.mark(&1, number))

    case Enum.find(bingos, &Bingo.bingo?(&1)) do
      nil -> {:cont, bingos}
      bingo -> {:halt, {String.to_integer(number), Bingo.sum(bingo)}}
    end
  end)
  |> IO.inspect(label: "winning bingo + sum")

(winning_number * sum) |> IO.inspect(label: "result")
