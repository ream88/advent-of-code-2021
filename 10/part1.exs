Code.require_file("../advent_of_code_2021.ex")

defmodule Day10.Part1 do
  def parse(line, stack \\ [])

  def parse([], _), do: :ok

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

points = %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}

AdventOfCode2021.stream_input_file()
|> Enum.map(&String.codepoints/1)
|> Enum.map(&Day10.Part1.parse(&1))
|> Enum.reject(&(&1 == :ok))
|> Enum.map(fn {:error, {_, invalid}} -> points[invalid] end)
|> Enum.sum()
|> IO.inspect(label: "result")
