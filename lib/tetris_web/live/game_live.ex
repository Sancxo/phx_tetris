defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    """
  end
end
