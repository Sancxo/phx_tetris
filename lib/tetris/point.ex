defmodule Tetris.Point do
  alias Tetris.{Tetromino, Game}
  # Types:
  @typedoc "The X axis (left/right) of the point, where 0 is the left extremity of the space."
  @type x() :: non_neg_integer()
  @typedoc "The Y axis (up/down) of the point, where 0 is the top extremity of the space."
  @type y() :: non_neg_integer()
  @typedoc "Represents the position of a point as a tuple of x and y coordinates."
  @type location(x, y) :: {x, y}
  @typedoc "Represents  the position of a point as a tuple of x and y coordinates with the shape of the full Tetromino to determine the point color."
  @type location_with_shape() :: {x(), y(), Tetromino.shape()}

  # Initialisation functions
  # Is it still used ?
  @spec origin() :: location(0, 0)
  def origin(), do: {0, 0}

  @doc "Set one point at a specific location."
  @spec set(location(x, y), location(x, y)) :: location(x, y)
  def set({x, y} = _point, {add_x, add_y} = _location), do: {x + add_x, y + add_y}

  @doc "Transforms a single point x-y coordinates tuple into a single point x-y coordinate tuple _with_ a shape so we can set the point color."
  @spec add_shape(location(x, y) | location_with_shape(), Tetromino.shape()) ::
          location_with_shape()
  def add_shape({x, y}, shape), do: {x, y, shape}
  def add_shape(point_with_shape, _), do: point_with_shape

  # Rotation functions
  @doc "Passes a point from X axis to Y axis (ex: {3, 2} becomes {2, 3})."
  @spec transpose(location(x, y)) :: location(x, y)
  def transpose({x, y}), do: {y, x}

  @doc "Passes a point through Y axis (ex: `{1, 2}` becomes `{4, 2}` or `{2, 2}` becomes `{3, 2}`)."
  @spec mirror(location(x, y)) :: location(x, y)
  def mirror({x, y}), do: {5 - x, y}

  @doc "Passes a point through X axis (ex: `{2, 1}` becomes `{2, 4}` or `{2, 2}` becomes `{2, 3}`)."
  @spec flip(location(x, y)) :: location(x, y)
  def flip({x, y}), do: {x, 5 - y}

  # Shift functions
  @doc "Moves one point to the left"
  @spec left(location(x, y)) :: location(x, y)
  def left({x, y}), do: {x - 1, y}

  @doc "Moves one point to the right"
  @spec right(location(x, y)) :: location(x, y)
  def right({x, y}), do: {x + 1, y}

  @doc "Moves one point down"
  @spec down(location(x, y)) :: location(x, y)
  def down({x, y}), do: {x, y + 1}

  # Boundaries functions
  @doc "Checks if a point is inside the limits of the game board and if it hasn't met another Tetromini point."
  @spec valid?(location_with_shape(), Game.junkyard()) :: boolean()
  def valid?(point, junkyard), do: point |> in_bounds?() && !collide?(point, junkyard)

  # Says if a single point of the Tetromino is inside the game board or will be outside.
  @spec in_bounds?(location_with_shape()) :: boolean()
  defp in_bounds?({x, _y, _shape}) when x < 1 or x > 10, do: false
  defp in_bounds?({_x, y, _shape}) when y > 20, do: false
  defp in_bounds?(_), do: true

  @spec collide?(location_with_shape(), Game.junkyard()) :: boolean()
  defp collide?({x, y, _shape}, junkyard), do: !!junkyard[{x, y}]
end
