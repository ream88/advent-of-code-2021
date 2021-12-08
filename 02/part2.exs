Code.compile_file("../advent_of_code_2021.ex")

{horizontal, depth, _aim} =
  AdventOfCode2021.stream_input_file()
  |> Enum.reduce({0, 0, 0}, fn input, {horizontal, depth, aim} ->
    [command, value] = String.split(input, " ")
    value = String.to_integer(value)

    case command do
      "forward" -> {horizontal + value, depth + aim * value, aim}
      "up" -> {horizontal, depth, aim - value}
      "down" -> {horizontal, depth, aim + value}
    end
  end)

IO.inspect(horizontal * depth, label: "result")
