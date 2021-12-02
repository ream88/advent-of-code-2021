[file] = System.argv()

file
|> File.stream!()
|> Stream.map(&String.trim(&1))
|> Stream.map(&String.to_integer(&1))
|> Enum.chunk_every(3, 1, :discard)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.reduce(0, fn [first, second], count ->
  if Enum.sum(first) < Enum.sum(second) do
    count + 1
  else
    count
  end
end)
|> IO.inspect(label: "increases")
