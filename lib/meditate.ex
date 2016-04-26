defmodule Mix.Tasks.Meditate do
  use Mix.Task
  alias Options

  def run(args) do
    Application.ensure_all_started(:elixir_koans)
    Code.compiler_options(ignore_module_conflict: true)
    Watcher.start

    Options.start(args)

    Options.initial_koan
    |> ok?
    |> Runner.modules_to_run
    |> Tracker.start
    |> Runner.run

    :timer.sleep(:infinity)
  end

  defp ok?(koan) do
    if Runner.koan?(koan) do
      koan
    else
      Display.invalid_koan(koan, Runner.modules)
    end
  end
end

