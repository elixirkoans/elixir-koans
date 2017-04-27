defmodule Mix.Tasks.Meditate do
  use Mix.Task
  alias Options

  @shortdoc "Start the koans"

  def run(args) do
    Application.ensure_all_started(:elixir_koans)
    Code.compiler_options(ignore_module_conflict: true)

    Options.start(args)

    {parsed, _, _} = OptionParser.parse(args)
    if Keyword.has_key?(parsed, :no_clear_screen) do
      Display.disable_clear()
    end

    modules = Options.initial_koan
    |> ok?
    |> Runner.modules_to_run

    Tracker.set_total(modules)
    Tracker.notify_on_complete(self())

    Runner.run(modules)

    Tracker.wait_until_complete()
    Display.congratulate()
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
