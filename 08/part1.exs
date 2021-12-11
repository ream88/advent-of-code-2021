Code.require_file("../advent_of_code_2021.ex")

AdventOfCode2021.stream_input_file()
|> Stream.map(&String.split(&1, "|"))
|> Stream.flat_map(&String.split(Enum.at(&1, 1), " ", trim: true))
|> Enum.count(fn output ->
  case String.length(output) do
    # 1
    2 -> true
    # 4
    4 -> true
    # 7
    3 -> true
    # 8
    7 -> true
    _ -> false
  end
end)
|> IO.inspect(label: "result")
