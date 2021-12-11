Code.require_file("../advent_of_code_2021.ex")

# Scrambled Seven Segment Display
defmodule SSSD do
  def new(values) do
    group = Enum.group_by(values, &length/1)

    Enum.reduce([1, 4, 7, 8, 9, 0, 6, 3, 2, 5], %{}, fn number, acc ->
      Map.put(acc, number, find(acc, group, number))
    end)
  end

  defp find(%{4 => four, 7 => seven}, %{6 => candidates}, 0) do
    # 0 is the 6 segment digit that shares segments with 7 but not with 4
    Enum.find(candidates, fn number ->
      !common?(four, number) && common?(seven, number)
    end)
  end

  defp find(_sssd, %{2 => [value]}, 1), do: value

  defp find(%{1 => one, 6 => six}, %{5 => candidates}, 2) do
    # 2 is the 5 segment digit that is not included in both 6 and 1
    Enum.find(candidates, fn number ->
      !common?(number, six) && !common?(one, number)
    end)
  end

  defp find(%{1 => one}, %{5 => candidates}, 3) do
    # 3 is the 5 segment digit that shares segments with 1
    Enum.find(candidates, fn number ->
      common?(one, number)
    end)
  end

  defp find(_sssd, %{4 => [value]}, 4), do: value

  defp find(%{6 => six}, %{5 => candidates}, 5) do
    # 5 is the 5 segment digit that is included in 6
    Enum.find(candidates, fn number ->
      common?(number, six)
    end)
  end

  defp find(%{4 => four, 7 => seven}, %{6 => candidates}, 6) do
    # 6 is the 6 segment digit that does not share segments with both 4 and 7
    Enum.find(candidates, fn number ->
      !common?(four, number) && !common?(seven, number)
    end)
  end

  defp find(_sssd, %{3 => [value]}, 7), do: value
  defp find(_sssd, %{7 => [value]}, 8), do: value

  defp find(%{4 => four, 7 => seven}, %{6 => candidates}, 9) do
    # 9 is the 6 segment digit that shares segments with both 4 and 7
    Enum.find(candidates, fn number ->
      common?(four, number) && common?(seven, number)
    end)
  end

  defp common?(first, second) do
    Enum.all?(first, &(&1 in second))
  end
end

AdventOfCode2021.stream_input_file()
|> Stream.map(&String.split(&1, " | "))
|> Stream.map(fn [input, output] ->
  digits =
    input
    |> String.split(" ")
    |> Enum.map(&String.codepoints/1)
    |> SSSD.new()
    |> Map.new(fn {key, value} -> {Enum.sort(value), key} end)

  output
  |> String.split(" ")
  |> Enum.map(&String.codepoints/1)
  |> Enum.map(&Enum.sort/1)
  |> Enum.map(&Map.fetch!(digits, &1))
  |> Integer.undigits()
end)
|> Enum.sum()
|> IO.inspect(label: "result")
