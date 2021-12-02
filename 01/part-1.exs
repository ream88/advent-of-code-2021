[file] = System.argv()

file
|> File.stream!()
|> Stream.map(&String.trim(&1))
|> Stream.map(&String.to_integer(&1))
|> Enum.chunk_every(2, 1, :discard)
|> Enum.reduce(0, fn
  [a, b], count when a < b -> count + 1
  _, count -> count
end)
|> IO.inspect(label: "increases")
