defmodule Tetris.Game do
  alias Tetris.{Tetromino, Points}

  defstruct [:tetro, score: 0, junkyard: %{}]

  def move(game, move_fn) do
    old = game.tetro
    new = game.tetro |> move_fn.()

    new
    |> Tetromino.show()
    |> Points.valid?()
    |> Tetromino.maybe_move(old, new)
  end
end
