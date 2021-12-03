Code.compile_file("../advent_of_code_2021.ex")

AdventOfCode2021.stream_input_file()
|> Stream.map(&String.to_integer(&1))
|> Enum.chunk_every(3, 1, :discard)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.count(fn [left, right] -> Enum.sum(left) < Enum.sum(right) end)
|> IO.inspect(label: "increases")
