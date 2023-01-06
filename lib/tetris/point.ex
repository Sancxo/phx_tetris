defmodule Tetris.Point do
  # Types:
  @typedoc "The X axis (left/right) of the point, where 0 is the left extremity of the space."
  @type x() :: non_neg_integer()
  @typedoc "The Y axis (up/down) of the point, where 0 is the top extremity of the space."
  @type y() :: non_neg_integer()
  @typedoc "Represents the position of a point as a tuple of x and y coordinates."
  @type location(x, y) :: {x, y}

  # Functions:
  @spec origin() :: location(0, 0)
  def origin(), do: {0, 0}

  @spec move(location(x, y), location(x, y)) :: location(x, y)
  def move({x, y}, {add_x, add_y}), do: {x + add_x, y + add_y}

  @spec left(location(x, y)) :: location(x, y)
  def left({x, y}), do: {x - 1, y}

  @spec right(location(x, y)) :: location(x, y)
  def right({x, y}), do: {x + 1, y}

  @spec down(location(x, y)) :: location(x, y)
  def down({x, y}), do: {x, y + 1}
end
