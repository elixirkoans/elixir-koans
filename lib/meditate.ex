defmodule Mix.Tasks.Meditate do
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:elixir_koans)
    Watcher.start
    Runner.run
    :timer.sleep(:infinity)
  end
end

