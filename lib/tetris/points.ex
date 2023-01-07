defmodule Tetris.Points do
  alias Tetris.Point

  # Should maybe be merged with Tetromino.show/1
  @doc "Sets all the Tetromino's points depending on the Tetromino coordinates."
  @spec set([Point.location(Point.x(), Point.y())], Point.location(Point.x(), Point.y())) ::
          [Point.location(Point.x(), Point.y())]
  def set(points, location), do: points |> Enum.map(fn point -> Point.set(point, location) end)
end
