Code.require_file("../advent_of_code_2021.ex")

fish =
  AdventOfCode2021.read_input_file()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

days = 80

1..days
|> Enum.reduce(fish, fn _, fish ->
  {fish, new} =
    fish
    |> Enum.map(fn
      fish when fish == 0 -> {6, 8}
      fish -> {fish - 1, nil}
    end)
    |> Enum.unzip()

  fish ++ Enum.reject(new, &is_nil/1)
end)
|> then(&IO.puts("There are #{length(&1)} fish after #{days} days"))
