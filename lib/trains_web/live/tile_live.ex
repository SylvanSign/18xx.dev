defmodule TrainsWeb.TileLive do
  use Phoenix.LiveView
  alias Phoenix.Socket.Broadcast
  alias Trains.TileState
  alias TrainsWeb.Endpoint

  def render(assigns) do
    ~L"""
    <svg style="display: block; width: 50%; margin: auto" version="1.1" xmlns="http://www.w3.org/2000/svg" width="500" height="500" viewBox="-100 -100 200 200">
    <g phx-click="rotate" transform="rotate(<%= @rotation %>)">
      <polygon points="-98.1495,0 -49.07475,-85 49.07475,-85 98.1495,0 49.07475,85 -49.07475,85" fill="<%= @color %>" stroke-linecap="round" stroke-linejoin="bevel" stroke-width="1" stroke="black"/>
      <line x1="0" x2="0" y1="-85" y2="85" stroke="black" stroke-width="10"/>
    </g>
    </svg>
    <button phx-click="color" style="display: block; width: 50%; margin: auto">Cycle Color</button>
    """
  end

  def mount(_, socket) do
    if connected?(socket) do
      Endpoint.subscribe("tile")
    end

    %{color: color, rotation: rotation} = TileState.state()

    socket = assign(socket, color: color, rotation: rotation)

    {:ok, socket}
  end

  def handle_event("rotate", _event, socket) do
    rotation = TileState.rotate()
    Endpoint.broadcast_from!(self(), "tile", "rotation", %{rotation: rotation})
    {:noreply, assign(socket, rotation: rotation)}
  end

  def handle_event("color", _event, socket) do
    color = TileState.cycle_color()
    Endpoint.broadcast_from!(self(), "tile", "color", %{color: color})
    {:noreply, assign(socket, color: color)}
  end

  def handle_info(
        %Broadcast{event: "rotation", payload: %{rotation: rotation}},
        socket
      ) do
    {:noreply, assign(socket, rotation: rotation)}
  end

  def handle_info(
        %Broadcast{event: "color", payload: %{color: color}},
        socket
      ) do
    {:noreply, assign(socket, color: color)}
  end
end
