Code.require_file("../advent_of_code_2021.ex")

defmodule Day10.Part2 do
  def parse(line, stack \\ [])

  def parse([], stack), do: {:ok, stack}

  def parse([char | rest], stack) do
    case {char, stack} do
      {"[", _} -> parse(rest, ["]" | stack])
      {"(", _} -> parse(rest, [")" | stack])
      {"{", _} -> parse(rest, ["}" | stack])
      {"<", _} -> parse(rest, [">" | stack])
      {char, [char | stack]} -> parse(rest, stack)
      {invalid, [expected | _]} -> {:error, {expected, invalid}}
    end
  end
end

points = %{")" => 1, "]" => 2, "}" => 3, ">" => 4}

scores =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(&String.codepoints/1)
  |> Enum.map(&Day10.Part2.parse(&1))
  |> Enum.reject(fn
    {:ok, _} -> false
    {:error, _} -> true
  end)
  |> Enum.map(fn {:ok, chars} ->
    Enum.reduce(chars, 0, fn char, acc ->
      acc * 5 + points[char]
    end)
  end)

scores
|> Enum.sort()
|> Enum.at(div(length(scores), 2))
|> IO.inspect(label: "result")
