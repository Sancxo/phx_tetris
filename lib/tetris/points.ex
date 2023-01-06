defmodule Tetris.Points do
  alias Tetris.Point

  @spec move([Point.location(Point.x(), Point.y())], Point.location(Point.x(), Point.y())) ::
          [Point.location(Point.x(), Point.y())]
  def move(points, change), do: points |> Enum.map(fn point -> Point.move(point, change) end)
end
