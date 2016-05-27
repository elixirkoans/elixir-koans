defmodule Runner do
  @modules [
    Equalities,
    Strings,
    Sigils,
    Numbers,
    Atoms,
    Tuples,
    Lists,
    KeywordLists,
    Maps,
    MapSets,
    Structs,
    PatternMatching,
    Functions,
    Enums,
    Processes,
    Tasks,
    Agents,
    Protocols,
  ]

  def koan?(koan), do: Enum.member?(@modules, koan)

  def modules, do: @modules

  def modules_to_run, do: Options.initial_koan |> modules_to_run
  def modules_to_run(start_module), do: Enum.drop_while(@modules, &(&1 != start_module))

  def run(modules) do
    Display.clear_screen()

    modules
    |> Enum.take_while( &(run_module(&1) == :passed))
  end

  def run_module(module) do
    module
    |> Execute.run_module(&track/3)
    |> display
  end

  defp track(:passed, module, koan), do: Tracker.completed(module, koan)
  defp track(_, _, _), do: nil

  defp display({:failed, error, module, name}) do
    Display.show_failure(error, module, name)
    :failed
  end
  defp display(_), do: :passed

end
