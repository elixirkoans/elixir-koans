defmodule Tracker do
  alias __MODULE__

  defstruct total: 0,
            koans: MapSet.new(),
            visited_modules: MapSet.new(),
            on_complete: :noop

  def start_link do
    Agent.start_link(fn -> %Tracker{} end, name: __MODULE__)
  end

  def notify_on_complete(pid) do
    Agent.update(__MODULE__, fn state -> %{state | on_complete: pid} end)
  end

  def set_total(modules) do
    total =
      modules
      |> Enum.flat_map(& &1.all_koans)
      |> Enum.count()

    Agent.update(__MODULE__, fn _ -> %Tracker{total: total} end)
  end

  def completed(module, koan) do
    Agent.update(__MODULE__, &mark_koan_completed(&1, module, koan))

    if complete?() do
      Agent.cast(__MODULE__, fn state ->
        send(state.on_complete, {self(), :complete})
        state
      end)
    end
  end

  def wait_until_complete() do
    pid = Process.whereis(Tracker)

    receive do
      {^pid, :complete} -> :ok
    end
  end

  defp mark_koan_completed(state, module, koan) do
    %{
      state
      | koans: MapSet.put(state.koans, koan),
        visited_modules: MapSet.put(state.visited_modules, module)
    }
  end

  def visited do
    summarize()[:visited_modules]
  end

  def complete? do
    %{total: total, current: completed} = summarize()
    total == completed
  end

  def summarize do
    state = Agent.get(__MODULE__, & &1)

    %{
      total: state.total,
      current: MapSet.size(state.koans),
      visited_modules: MapSet.to_list(state.visited_modules)
    }
  end
end
