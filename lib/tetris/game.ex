defmodule Tetris.Game do
  alias Tetris.{Tetromino, Points}

  defstruct [:tetro, points: [], score: 0, junkyard: %{}]

  def new(), do: __struct__() |> new_tetromino() |> show()

  def new_tetromino(game), do: %{game | tetro: Tetromino.new_random()} |> show()

  def show(game), do: %{game | points: game.tetro |> Tetromino.show()}

  def move(game, move_fn) do
    old = game.tetro
    new = game.tetro |> move_fn.()

    tetro =
      new
      |> Tetromino.show()
      |> Points.valid?()
      |> Tetromino.maybe_move(old, new)

    %{game | tetro: tetro} |> show()
  end

  def right(game), do: game |> move(&Tetromino.right/1)
  def left(game), do: game |> move(&Tetromino.left/1)
  def rotate(game), do: game |> move(&Tetromino.rotate/1)
  def down(game), do: game |> move(&Tetromino.down/1)
end
