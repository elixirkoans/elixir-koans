defmodule Tracker do
  def start(modules) do
    total = modules
            |> Enum.flat_map(&(&1.all_koans))
            |> Enum.count

    Agent.start_link(fn -> %{total: total,
                             koans: MapSet.new(),
                             visited_modules: MapSet.new()} end, name: __MODULE__)
    modules
  end

  defp get(),  do: Agent.get(__MODULE__, &(&1))

  def completed(module, koan) do
    Agent.update(__MODULE__, fn(%{koans: completed, visited_modules: modules} = all) ->
      %{ all | koans: MapSet.put(completed, koan),
               visited_modules: MapSet.put(modules, module)}
    end)
  end

  def visited do
    summarize[:visited_modules]
  end

  def complete? do
    %{total: total, current: completed} = summarize
    total == completed
  end

  def summarize, do: get |> summarize
  defp summarize(%{total: total,
                  koans: completed,
                  visited_modules: modules}) do
    %{
      total: total,
      current: MapSet.size(completed),
      visited_modules: MapSet.to_list(modules)
    }
  end
end
