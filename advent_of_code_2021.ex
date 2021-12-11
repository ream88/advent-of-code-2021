defmodule AdventOfCode2021 do
  def stream_input_file() do
    System.argv()
    |> Enum.at(0)
    |> File.stream!()
    |> Stream.map(&String.trim(&1))
  end

  def read_input_file() do
    System.argv()
    |> Enum.at(0)
    |> File.read!()
    |> String.trim()
  end

  def to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {value, x} ->
        {{x, y}, value}
      end)
    end)
    |> Map.new()
  end
end
