defmodule Tetris.Tetromino do
  alias Tetris.Point

  @typep shape() :: :i | :t | :o | :l | :j | :z | :s
  @typep degree() :: 0 | 90 | 180 | 270

  @typedoc "The objects the player has to interact with. The have three parameters: a shape, a rotation and a location."
  @type tetromino() :: %__MODULE__{
          shape: shape(),
          rotation: degree(),
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
  def rotate(tetro), do: %{tetro | rotation: increase_degree(tetro.rotation)}

  # Privates
  @spec random_shape() :: shape()
  defp random_shape(), do: ~w[i t o l j z s]a |> Enum.random()
  @spec random_rotation() :: degree()
  defp random_rotation(), do: [0, 90, 180, 270] |> Enum.random()
  @spec random_location() :: Point.location(Point.x(), Point.y())
  defp random_location(), do: {0..9 |> Enum.random(), 0}

  @spec increase_degree(degree()) :: degree()
  defp increase_degree(270), do: 0
  defp increase_degree(degree), do: degree + 90
end
