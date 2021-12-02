defmodule AdventOfCode2021 do
  def stream_input_file() do
    [file] = System.argv()

    file
    |> File.stream!()
    |> Stream.map(&String.trim(&1))
  end
end
