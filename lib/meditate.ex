defmodule Mix.Tasks.Meditate do
  use Mix.Task

  @shortdoc "Start the koans"

  def run(args) do
    Application.ensure_all_started(:elixir_koans)
    Code.compiler_options(ignore_module_conflict: true)

    {parsed, _, _} = OptionParser.parse(args)

    modules =
      parsed
      |> initial_module
      |> ok?
      |> Runner.modules_to_run()

    Tracker.set_total(modules)
    Tracker.notify_on_complete(self())

    set_clear_screen(parsed)
    Runner.run(modules)

    Tracker.wait_until_complete()
    Display.congratulate()
  end

  defp initial_module(parsed) do
    name = Keyword.get(parsed, :koan, "Equalities")
    String.to_atom("Elixir." <> name)
  end

  defp set_clear_screen(parsed) do
    if Keyword.has_key?(parsed, :no_clear_screen) do
      Display.disable_clear()
    end
  end

  defp ok?(koan) do
    if Runner.koan?(koan) do
      koan
    else
      Display.invalid_koan(koan, Runner.modules())
      exit(:normal)
    end
  end
end
