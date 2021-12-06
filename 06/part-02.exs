Code.require_file("../advent_of_code_2021.ex")

fish =
  AdventOfCode2021.read_input_file()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)
  |> Enum.frequencies()

days = 256

1..days
|> Enum.reduce(fish, fn day, fish ->
  fish
  |> Enum.reduce(%{}, fn
    {0, quantity}, acc -> acc |> Map.update(6, quantity, &(&1 + quantity)) |> Map.put(8, quantity)
    {n, quantity}, acc -> acc |> Map.update(n - 1, quantity, &(&1 + quantity))
  end)
  |> tap(fn fish ->
    count = fish |> Map.values() |> Enum.sum()
    IO.puts("There are #{count} fish after #{day} days")
  end)
end)
