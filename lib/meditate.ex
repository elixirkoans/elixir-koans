defmodule Mix.Tasks.Meditate do
  use Mix.Task
  alias Options

  def run(args) do
    Application.ensure_all_started(:elixir_koans)
    Code.compiler_options(ignore_module_conflict: true)
    Watcher.start

    options = Options.parse(args)
    Runner.run(options)

    :timer.sleep(:infinity)
  end
end

