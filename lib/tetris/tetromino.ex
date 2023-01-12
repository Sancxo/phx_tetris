defmodule Tetris.Tetromino do
  alias Tetris.{Point, Points}

  @typedoc "The seven types of tetromino shape."
  @type shape() :: :i | :t | :o | :l | :j | :z | :s
  @typedoc "The four rotations possible in degrees."
  @type degree() :: 0 | 90 | 180 | 270

  @typedoc """
  The shaped block the player has to interact with.
  It has three parameters: a shape, a rotation and a location.
  """
  @type tetromino() :: %__MODULE__{
          shape: shape(),
          rotation: degree(),
          location: Point.location(Point.x(), Point.y())
        }

  defstruct shape: :l, rotation: 0, location: {5, 0}

  @doc "Creates a new Tetromino struct with random shape, location and rotation."
  @spec new_random() :: tetromino()
  def new_random(),
    do: new(shape: random_shape(), rotation: random_rotation(), location: random_location())

  @doc "Draws and displays the Tetromino on the game board."
  @spec show(tetromino()) :: [Point.location(Point.x(), Point.y())]
  def show(tetro) do
    tetro
    |> points()
    |> Points.rotate(tetro.rotation)
    |> Points.set(tetro.location)
    |> Points.add_shape(tetro.shape)
  end

  @spec left(tetromino()) :: tetromino()
  def left(tetro), do: %{tetro | location: Point.left(tetro.location)}

  @spec right(tetromino()) :: tetromino()
  def right(tetro), do: %{tetro | location: Point.right(tetro.location)}

  @spec down(tetromino()) :: tetromino()
  def down(tetro), do: %{tetro | location: Point.down(tetro.location)}

  @spec rotate(tetromino()) :: tetromino()
  def rotate(tetro), do: %{tetro | rotation: increase_degree(tetro.rotation)}

  @doc """
  Returns a boolean to decide if a Tetromino can move or if it keeps its previous location
  because it has reached a lateral boundary.
  """
  @spec maybe_move(boolean(), tetromino(), tetromino()) :: tetromino()
  def maybe_move(false, old, _new), do: old
  def maybe_move(true, _old, new), do: new

  # Privates
  @spec new(list()) :: struct()
  defp new(options), do: __struct__(options)

  @spec random_shape() :: shape()
  defp random_shape(), do: ~w[i t o l j z s]a |> Enum.random()
  @spec random_rotation() :: degree()
  defp random_rotation(), do: [0, 90, 180, 270] |> Enum.random()
  @spec random_location() :: Point.location(Point.x(), Point.y())
  defp random_location(), do: {0..6 |> Enum.random(), 0}

  # Draws the Tetromino after its shape.
  @spec points(tetromino()) :: [Point.location(Point.x(), Point.y())]
  defp points(%{shape: :i}), do: [{2, 1}, {2, 2}, {2, 3}, {2, 4}]
  defp points(%{shape: :t}), do: [{1, 2}, {2, 2}, {3, 2}, {2, 3}]
  defp points(%{shape: :o}), do: [{2, 2}, {3, 2}, {2, 3}, {3, 3}]
  defp points(%{shape: :l}), do: [{2, 1}, {2, 2}, {2, 3}, {3, 3}]
  defp points(%{shape: :j}), do: [{3, 1}, {3, 2}, {3, 3}, {2, 3}]
  defp points(%{shape: :z}), do: [{1, 2}, {2, 2}, {2, 3}, {3, 3}]
  defp points(%{shape: :s}), do: [{2, 2}, {3, 2}, {1, 3}, {2, 3}]

  @spec increase_degree(degree()) :: degree()
  defp increase_degree(270), do: 0
  defp increase_degree(degree), do: degree + 90
end
