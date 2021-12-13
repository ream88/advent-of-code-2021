Code.require_file("../advent_of_code_2021.ex")

defmodule Paper do
  def new(points) do
    points
    |> Enum.reduce(%{}, fn point, acc ->
      [x, y] = Enum.map(point, &String.to_integer/1)
      Map.put(acc, {x, y}, "#")
    end)
    |> Map.new()
  end

  def fold(paper, {axis, line}) do
    index = if axis == :x, do: 0, else: 1

    paper
    |> Map.keys()
    |> Enum.filter(&(elem(&1, index) > line))
    |> Enum.reduce(paper, fn {x, y} = point, paper ->
      folded_point =
        case index do
          0 -> {x - (x - line) * 2, y}
          1 -> {x, y - (y - line) * 2}
        end

      paper
      |> Map.delete(point)
      |> Map.put(folded_point, "#")
    end)
  end

  def size(paper) do
    width = paper |> Map.keys() |> Enum.map(&elem(&1, 0)) |> Enum.max()
    height = paper |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()

    {width, height}
  end

  def print(paper) do
    {width, height} = size(paper)

    for y <- 0..height do
      iodata =
        for x <- 0..width do
          Map.get(paper, {x, y}, ".")
        end

      IO.puts(IO.iodata_to_binary(iodata))
    end

    paper
  end

  def length(paper) do
    Enum.count(paper)
  end
end

[points, foldings] =
  AdventOfCode2021.read_input_file()
  |> String.split("\n\n", trim: true)
  |> Enum.map(&String.split(&1, "\n", trim: true))

foldings =
  foldings
  |> Enum.map(fn <<"fold along ", axis::binary-size(1), "=", value::binary>> ->
    {String.to_atom(axis), String.to_integer(value)}
  end)

paper =
  points
  |> Enum.map(&String.split(&1, ","))
  |> Paper.new()

foldings
|> Enum.take(1)
|> Enum.reduce(paper, &Paper.fold(&2, &1))
|> Paper.print()
|> Paper.length()
|> IO.inspect(label: "result")
