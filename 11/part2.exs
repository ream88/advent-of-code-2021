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

  def all_flashing?(octopi) do
    octopi |> Map.values() |> Enum.all?(&(&1 == 0))
  end

  def flashes(octopi) do
    octopi |> Map.values() |> Enum.all?(&(&1 == 0))
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

Stream.iterate(1, &(&1 + 1))
|> Enum.reduce_while(octopi, fn step, octopi ->
  octopi = Octopi.step(octopi)

  if Octopi.all_flashing?(octopi) do
    {:halt, step}
  else
    {:cont, octopi}
  end
end)
|> IO.inspect(label: "result")
