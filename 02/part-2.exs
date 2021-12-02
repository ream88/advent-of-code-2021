[file] = System.argv()

{horizontal, depth, _aim} =
  file
  |> File.stream!()
  |> Stream.map(&String.trim(&1))
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
