Code.compile_file("../advent_of_code_2021.ex")

AdventOfCode2021.stream_input_file()
|> Stream.map(&String.to_integer(&1))
|> Enum.chunk_every(2, 1, :discard)
|> Enum.reduce(0, fn
  [a, b], count when a < b -> count + 1
  _, count -> count
end)
|> IO.inspect(label: "increases")
