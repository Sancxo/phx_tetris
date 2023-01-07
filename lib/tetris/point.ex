defmodule Tetris.Point do
  # Types:
  @typedoc "The X axis (left/right) of the point, where 0 is the left extremity of the space."
  @type x() :: non_neg_integer()
  @typedoc "The Y axis (up/down) of the point, where 0 is the top extremity of the space."
  @type y() :: non_neg_integer()
  @typedoc "Represents the position of a point as a tuple of x and y coordinates."
  @type location(x, y) :: {x, y}

  # Functions:
  # Is it still used ?
  @spec origin() :: location(0, 0)
  def origin(), do: {0, 0}

  @doc "Set one point at a specific location"
  @spec set(location(x, y), location(x, y)) :: location(x, y)
  def set({x, y} = _point, {add_x, add_y} = _location), do: {x + add_x, y + add_y}

  @doc "Moves one point to the left"
  @spec left(location(x, y)) :: location(x, y)
  def left({x, y}), do: {x - 1, y}

  @doc "Moves one point to the right"
  @spec right(location(x, y)) :: location(x, y)
  def right({x, y}), do: {x + 1, y}

  @doc "Moves one point down"
  @spec down(location(x, y)) :: location(x, y)
  def down({x, y}), do: {x, y + 1}
end
