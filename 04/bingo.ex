defmodule Bingo do
  def new(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn string -> {String.to_integer(string), false} end)
  end

  def mark(bingo, input) do
    number = String.to_integer(input)

    bingo
    |> Enum.map(fn
      {^number, _} -> {number, true}
      {number, marked} -> {number, marked}
    end)
  end

  def bingo?(bingo) do
    check?(bingo, 0..4) ||
      check?(bingo, 5..9) ||
      check?(bingo, 10..14) ||
      check?(bingo, 15..19) ||
      check?(bingo, 20..24) ||
      check?(bingo, [0, 5, 10, 15, 20]) ||
      check?(bingo, [1, 6, 11, 16, 21]) ||
      check?(bingo, [2, 7, 12, 17, 22]) ||
      check?(bingo, [3, 8, 13, 18, 23]) ||
      check?(bingo, [4, 9, 14, 19, 24])
  end

  defp check?(bingo, indexes) do
    indexes
    |> Enum.reduce(true, fn index, acc ->
      {_, marked} = Enum.at(bingo, index)
      acc && marked
    end)
  end

  def sum(bingo) do
    bingo
    |> Enum.filter(fn {_, marked} -> !marked end)
    |> Enum.map(fn {number, _} -> number end)
    |> Enum.sum()
  end
end
