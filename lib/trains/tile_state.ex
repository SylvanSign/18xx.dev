defmodule Trains.TileState do
  use GenServer

  @name __MODULE__
  @diff 60

  def start_link([]) do
    GenServer.start_link(@name, [], name: @name)
  end

  def state do
    GenServer.call(@name, :state)
  end

  def cycle_color do
    GenServer.call(@name, :cycle_color)
  end

  def rotate do
    GenServer.call(@name, :rotate)
  end

  def init([]) do
    {:ok, %{color: :yellow, rotation: 0}}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:rotate, _from, %{rotation: rotation} = state) do
    new_rotation = rotation + @diff
    {:reply, new_rotation, %{state | rotation: new_rotation}}
  end

  def handle_call(:cycle_color, _from, %{color: color} = state) do
    next_color = next_color(color)
    {:reply, next_color, %{state | color: next_color}}
  end

  defp next_color(:yellow), do: :green
  defp next_color(:green), do: :brown
  defp next_color(:brown), do: :grey
  defp next_color(:grey), do: :yellow
end
