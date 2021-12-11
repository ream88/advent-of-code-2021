Code.require_file("../advent_of_code_2021.ex")

defmodule Octopi do
  def step(octopi) do
    octopi
    |> Enum.reduce(octopi, fn {{x, y}, _}, octopi ->
      update_when_in_bounds(octopi, {x, y})
    end)
    |> Enum.map(fn {{x, y}, octopus} ->
      {{x, y}, if(octopus == -1, do: 0, else: octopus)}
    end)
    |> Map.new()
  end

  defp update_when_in_bounds(octopi, {x, y}) do
    case Map.get(octopi, {x, y}) do
      nil ->
        octopi

      9 ->
        octopi
        |> Map.put({x, y}, -1)
        |> update_when_in_bounds({x, y - 1})
        |> update_when_in_bounds({x + 1, y - 1})
        |> update_when_in_bounds({x + 1, y})
        |> update_when_in_bounds({x + 1, y + 1})
        |> update_when_in_bounds({x, y + 1})
        |> update_when_in_bounds({x - 1, y + 1})
        |> update_when_in_bounds({x - 1, y})
        |> update_when_in_bounds({x - 1, y - 1})

      # -1 are ignored in this step
      -1 ->
        octopi

      _ ->
        Map.update(octopi, {x, y}, 0, &(&1 + 1))
    end
  end

  def flashes(octopi) do
    octopi |> Map.values() |> Enum.count(&(&1 == 0))
  end

  def size(octopi) do
    octopi
    |> Map.keys()
    |> Enum.max()
  end

  def print(octopi) do
    {width, height} = size(octopi)

    for y <- 0..height do
      for x <- 0..width do
        to_string(Map.get(octopi, {x, y}))
      end
      |> IO.iodata_to_binary()
      |> IO.puts()
    end
  end
end

octopi =
  AdventOfCode2021.stream_input_file()
  |> Enum.map(fn line -> line |> String.codepoints() |> Enum.map(&String.to_integer/1) end)
  |> AdventOfCode2021.to_map()

1..100
|> Enum.reduce({octopi, 0}, fn _, {octopi, flashes} ->
  octopi = Octopi.step(octopi)
  flashes = Octopi.flashes(octopi) + flashes

  {octopi, flashes}
end)
|> then(&elem(&1, 1))
|> IO.inspect(label: "result")
