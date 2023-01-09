defmodule TetrisWeb.GameLive do
  alias Tetris.Tetromino
  use TetrisWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(500, :tick)
    {:ok, socket |> new_tetromino() |> show()}
  end

  @impl true
  def handle_info(:tick, socket), do: {:noreply, socket |> tetro_down() |> rotate() |> show()}

  @impl true
  def render(assigns) do
    ~H"""
    <section class="phx-hero">
    <h1>TETRIS</h1>
      <%= render_board(assigns) %>
      <pre>
        <%= @tetro |> inspect() %>
      </pre>
    </section>
    """
  end

  # PRIVATES
  defp render_board(assigns) do
    ~H"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~H"""
    <%= for {x, y} <- @points do %>
      <rect width="20" height="20" x={ (x - 1) * 20 } y={ (y - 1) * 20 } style={" fill: #{color(@tetro.shape)}; "} />
    <% end %>
    """
  end

  defp color(:i), do: "Indigo"
  defp color(:t), do: "Tomato"
  defp color(:o), do: "Orange"
  defp color(:l), do: "Lime"
  defp color(:j), do: "navaJowhite"
  defp color(:z), do: "aZure"
  defp color(:s), do: "Steelblue"

  # Assigns
  defp new_tetromino(socket), do: socket |> assign(tetro: Tetromino.new_random())

  defp show(%{assigns: %{tetro: tetro}} = socket),
    do: socket |> assign(points: Tetromino.show(tetro))

  defp rotate(%{assigns: %{tetro: tetro}} = socket),
    do: socket |> assign(tetro: tetro |> Tetromino.rotate())

  defp tetro_down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket),
    do: socket |> new_tetromino()

  defp tetro_down(%{assigns: %{tetro: tetro}} = socket),
    do: socket |> assign(tetro: tetro |> Tetromino.down())
end
