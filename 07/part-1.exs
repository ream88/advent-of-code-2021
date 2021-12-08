Code.require_file("../advent_of_code_2021.ex")

crabs =
  AdventOfCode2021.read_input_file()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

{min, max} = Enum.min_max(crabs)

for pos <- min..max do
  crabs
  |> Enum.map(&abs(&1 - pos))
  |> Enum.sum()
end
|> Enum.min()
|> IO.inspect(label: "result")
