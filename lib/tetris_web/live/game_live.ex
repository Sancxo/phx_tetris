defmodule TetrisWeb.GameLive do
  alias Tetris.Tetromino
  use TetrisWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok, socket |> new_tetromino()}
  end

  @impl true
  def handle_info(:tick, socket), do: {:noreply, socket |> tetro_down()}

  @impl true
  def render(assigns) do
    ~H"""
    <%= {x, y} = @tetro.location %>
    <section class="phx-hero">
      <pre>
      shape: <%= @tetro.shape |> inspect() %>
      rotation: <%= @tetro.rotation |> inspect() %>
      location: {<%= x %>, <%= y %>}
      </pre>
    </section>
    """
  end

  # PRIVATES
  defp new_tetromino(socket), do: socket |> assign(tetro: Tetromino.new_random())

  defp tetro_down(%{assigns: %{tetro: tetro}} = socket),
    do: socket |> assign(tetro: tetro |> Tetromino.down())
end
