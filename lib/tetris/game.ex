defmodule Tetris.Game do
  alias Tetris.{Tetromino, Points}

  defstruct [:tetro, points: [], score: 0, junkyard: []]

  def new(), do: __struct__() |> new_tetromino() |> show()

  def new_tetromino(game), do: %{game | tetro: Tetromino.new_random()} |> show()

  def show(game), do: %{game | points: game.tetro |> Tetromino.show()}

  def move(game, move_fn) do
    {old, new, valid?} = game |> move_data(move_fn)

    tetro =
      valid?
      |> Tetromino.maybe_move(old, new)

    %{game | tetro: tetro} |> show()
  end

  def right(game), do: game |> move(&Tetromino.right/1)
  def left(game), do: game |> move(&Tetromino.left/1)
  def rotate(game), do: game |> move(&Tetromino.rotate/1)
  # def down(game), do: game |> move(&Tetromino.down/1)

  def down(game) do
    {old, new, valid?} = move_data(game, &Tetromino.down/1)

    game |> move_down_or_merge(old, new, valid?)
  end

  defp move_down_or_merge(game, _old, new, true), do: %{game | tetro: new} |> show()

  defp move_down_or_merge(game, old, _new, false),
    do: game |> merge(old) |> new_tetromino() |> show()

  defp merge(game, old) do
    new_junkyard =
      old
      |> Tetromino.show()
      |> Enum.map(fn {x, y} -> {x, y} end)
      |> Enum.into(game.junkyard)

    %{game | junkyard: new_junkyard}
  end

  def junkyard(game) do
    game.junkyard
  end

  defp move_data(game, move_fn) do
    old = game.tetro
    new = game.tetro |> move_fn.()

    valid? =
      new
      |> Tetromino.show()
      |> Points.valid?()

    {old, new, valid?}
  end
end
