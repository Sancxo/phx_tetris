defmodule Tetris.Tetromino do
  alias Tetris.Point
  @type shape() :: :i | :t | :o | :l | :j | :z | :s
  @type rotation() :: 0 | 90 | 180 | 270
  defstruct shape: :l, rotation: 0, location: {5, 0}

  @spec new(list()) :: struct()
  def new(options \\ []), do: __struct__(options)

  @doc "Creates a new Tetromino with random shape, location and rotation."
  @spec new_random() ::
          %__MODULE__{
            shape: shape(),
            rotation: rotation(),
            location: Point.location(Point.x(), Point.y())
          }
  def new_random(),
    do: new(shape: random_shape(), rotation: random_rotation(), location: random_location())

  # Privates
  defp random_shape(), do: ~w[i t o l j z s]a |> Enum.random()
  defp random_rotation(), do: [0, 90, 180, 270] |> Enum.random()
  defp random_location(), do: {0..10 |> Enum.random(), 0}
end
