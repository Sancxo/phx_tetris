defmodule Tetris.Point do
  # Types:
  @typedoc "The X axis (left/right) of the point."
  @type x() :: number()
  @typedoc "The Y axis (up/down) of the point. In Tetris we can't go up, so no negative numbers"
  @type y() :: non_neg_integer()
  @typedoc "Represents the position of a point as a tuple of x and y coordinates."
  @type point(x, y) :: {x, y}

  # Functions:
  @spec origin() :: point(0, 0)
  def origin(), do: {0, 0}

  @spec left(point(x, y)) :: point(x, y)
  def left({x, y}), do: {x - 1, y}

  @spec right(point(x, y)) :: point(x, y)
  def right({x, y}), do: {x + 1, y}

  @spec down(point(x, y)) :: point(x, y)
  def down({x, y}), do: {x, y + 1}
end
