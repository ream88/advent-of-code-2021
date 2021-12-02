Code.compile_file("../advent_of_code_2021.ex")

{horizontal, depth} =
  AdventOfCode2021.stream_input_file()
  |> Enum.reduce({0, 0}, fn input, {horizontal, depth} ->
    [command, value] = String.split(input, " ")
    value = String.to_integer(value)

    case command do
      "forward" -> {horizontal + value, depth}
      "up" -> {horizontal, depth - value}
      "down" -> {horizontal, depth + value}
    end
  end)

IO.inspect(horizontal * depth, label: "result")
