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
end
