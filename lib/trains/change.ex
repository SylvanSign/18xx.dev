defmodule Trains.Change do
  use GenServer

  @name __MODULE__

  def start_link([]) do
    GenServer.start_link(@name, [], name: @name)
  end

  def state do
    GenServer.call(@name, :state)
  end

  def increment do
    GenServer.call(@name, :increment)
  end

  def decrement do
    GenServer.call(@name, :decrement)
  end

  def init([]) do
    {:ok, 0}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:increment, _from, state) do
    new_state = state + 1
    {:reply, new_state, new_state}
  end

  def handle_call(:decrement, _from, state) do
    new_state = state - 1
    {:reply, new_state, new_state}
  end
end
