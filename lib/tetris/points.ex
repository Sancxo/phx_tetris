defmodule Tetris.Points do
  alias Tetris.{Tetromino, Point}

  @typedoc "A list of Point.location(Point.x(), Point.y())."
  @type point_list() :: [Point.location(Point.x(), Point.y())]

  @doc "Sets all the Tetromino's points depending on the Tetromino coordinates."
  @spec set(point_list(), Point.location(Point.x(), Point.y())) :: point_list()
  def set(points, location), do: points |> Enum.map(fn point -> point |> Point.set(location) end)

  @doc "Transforms a list of tuples of two x-y coordinates into a list of tuples of two x-y coordinates _with_ a Tetromino shape."
  @spec add_shape(point_list(), Tetromino.shape()) :: point_list()
  def add_shape(points, shape),
    do: points |> Enum.map(fn point -> point |> Point.add_shape(shape) end)

  @doc "Rotates the entire Tetromino."
  @spec rotate(point_list(), Tetromino.degree()) :: point_list()
  def rotate(points, 0), do: points
  def rotate(points, 90), do: points |> Enum.map(&(&1 |> Point.flip() |> Point.transpose()))
  def rotate(points, 180), do: points |> Enum.map(&(&1 |> Point.mirror() |> Point.flip()))
  def rotate(points, 270), do: points |> Enum.map(&(&1 |> Point.mirror() |> Point.transpose()))

  @doc "Determines if the Tetromino has reached a lateral boundary."
  @spec valid?(point_list()) :: boolean
  def valid?(points), do: Enum.all?(points, &Point.in_bounds?/1)
end
