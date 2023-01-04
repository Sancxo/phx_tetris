defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok, socket |> new_game()}
  end

  def new_game(socket) do
    socket
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    """
  end
end
