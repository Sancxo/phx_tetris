defmodule TetrisWeb.GameLive.Play do
  alias Tetris.Game
  use TetrisWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(500, :tick)
    {:ok, socket |> new_game()}
  end

  @impl true
  def handle_info(:tick, socket), do: {:noreply, socket |> down()}

  @impl true
  def handle_event("keystroke", %{"key" => " "}, socket) do
    {:noreply, socket |> rotate()}
  end

  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket), do: {:noreply, socket |> left()}

  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket),
    do: {:noreply, socket |> right()}

  def handle_event("keystroke", _, socket), do: {:noreply, socket}

  # PRIVATES
  def render_board(assigns) do
    ~H"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~H"""
    <%= for {x, y, shape} <- @game.points ++ Game.junkyard(@game) do %>
      <rect width="20" height="20" x={ (x - 1) * 20 } y={ (y - 1) * 20 } style={" fill: #{color(shape)}; "} />
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
  defp new_game(socket), do: socket |> assign(game: Game.new())

  defp rotate(%{assigns: %{game: game}} = socket),
    do: socket |> assign(game: game |> Game.rotate())

  defp left(%{assigns: %{game: game}} = socket),
    do: socket |> assign(game: game |> Game.left())

  defp right(%{assigns: %{game: game}} = socket),
    do: socket |> assign(game: game |> Game.right())

  defp down(%{assigns: %{game: game}} = socket),
    do: socket |> assign(game: game |> Game.down())
end
