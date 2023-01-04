defmodule Tetris.Tetromino do
  alias Tetris.Point

  @typep shape() :: :i | :t | :o | :l | :j | :z | :s
  @typep rotation() :: 0 | 90 | 180 | 270

  @typedoc "The objects the player has to interact with. The have three parameters: a shape, a rotation and a location."
  @type tetromino() :: %__MODULE__{
          shape: shape(),
          rotation: rotation(),
          location: Point.location(Point.x(), Point.y())
        }

  defstruct shape: :l, rotation: 0, location: {5, 0}

  @spec new(list()) :: struct()
  def new(options \\ []), do: __struct__(options)

  @doc "Creates a new Tetromino with random shape, location and rotation."
  @spec new_random() :: tetromino()
  def new_random(),
    do: new(shape: random_shape(), rotation: random_rotation(), location: random_location())

  @spec left(tetromino()) :: tetromino()
  def left(tetro), do: %{tetro | location: Point.left(tetro.location)}

  @spec right(tetromino()) :: tetromino()
  def right(tetro), do: %{tetro | location: Point.right(tetro.location)}

  @spec down(tetromino()) :: tetromino()
  def down(tetro), do: %{tetro | location: Point.down(tetro.location)}

  @spec rotate(tetromino()) :: tetromino()
  def rotate(tetro), do: %{tetro | rotation: increase_degrees(tetro.rotation)}

  # Privates
  defp random_shape(), do: ~w[i t o l j z s]a |> Enum.random()
  defp random_rotation(), do: [0, 90, 180, 270] |> Enum.random()
  defp random_location(), do: {0..9 |> Enum.random(), 0}

  defp increase_degrees(270), do: 0
  defp increase_degrees(n), do: n + 90
end
