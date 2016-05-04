defmodule Mix.Tasks.Meditate do
  use Mix.Task
  alias Options

  @shortdoc "Start the koans"

  def run(args) do
    Application.ensure_all_started(:elixir_koans)
    Code.compiler_options(ignore_module_conflict: true)
    {:ok, watcher} = Watcher.start
    Process.monitor(watcher)

    Options.start(args)

    Options.initial_koan
    |> ok?
    |> Runner.modules_to_run
    |> Tracker.start
    |> Runner.run

    if Tracker.complete? do
      Display.congratulate
      exit(:normal)
    end

    receive do
      {:DOWN, _references, :process, ^watcher, _reason} -> nil
    end
  end

  defp ok?(koan) do
    if Runner.koan?(koan) do
      koan
    else
      Display.invalid_koan(koan, Runner.modules)
      exit(:normal)
    end
  end
end
