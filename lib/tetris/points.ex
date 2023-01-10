defmodule Tetris.Points do
  alias Tetris.Tetromino
  alias Tetris.Point

  # Should maybe be merged with Tetromino.show/1
  @doc "Sets all the Tetromino's points depending on the Tetromino coordinates."
  @spec set([Point.location(Point.x(), Point.y())], Point.location(Point.x(), Point.y())) ::
          [Point.location(Point.x(), Point.y())]
  def set(points, location), do: points |> Enum.map(fn point -> point |> Point.set(location) end)

  @spec rotate([Point.location(Point.x(), Point.y())], Tetromino.degree()) :: [
          Point.location(Point.x(), Point.y())
        ]
  @doc "Rotates the entire Tetromino."
  def rotate(points, 0), do: points
  def rotate(points, 90), do: points |> Enum.map(&(&1 |> Point.flip() |> Point.transpose()))
  def rotate(points, 180), do: points |> Enum.map(&(&1 |> Point.mirror() |> Point.flip()))
  def rotate(points, 270), do: points |> Enum.map(&(&1 |> Point.mirror() |> Point.transpose()))

  @doc "Determines if the Tetromino has reached a lateral boundary."
  @spec valid?([Point.location(Point.x(), Point.y())]) :: boolean
  def valid?(points), do: Enum.all?(points, &Point.in_bounds?/1)
end
