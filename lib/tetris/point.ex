defmodule Tetris.Point do
  # Types:
  @typedoc "The X axis (left/right) of the point, where 0 is the left extremity of the space."
  @type x() :: non_neg_integer()
  @typedoc "The Y axis (up/down) of the point, where 0 is the top extremity of the space."
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
