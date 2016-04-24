defmodule Runner do
  @modules [
    Equalities,
    Strings,
    Tuples,
    Lists,
    Maps,
    Structs,
    PatternMatching,
    Functions,
    Enums,
    Processes,
    Tasks,
    Agents,
  ]

  def koan?(koan), do: Enum.member?(@modules, koan)
  def modules, do: @modules

  def run do
    Options.initial_koan
    |>run
  end

  def run(start_module) when start_module in @modules, do: run(start_module, @modules)
  def run(start_module), do: Display.invalid_koan(start_module, @modules)

  def run(start_module, modules) do
    Display.clear_screen()

    modules
    |> Enum.drop_while( &(&1 != start_module))
    |> Enum.take_while( &(run_module(&1) == :passed))
  end

  def run_module(module) do
    module
    |> Display.considering
    |> Execute.run_module(&track/2)
    |> display

  end

  defp track(:passed, koan), do: Tracker.completed(koan)
  defp track(_, _), do: nil

  defp display({:failed, error, module, name}) do
    Display.show_failure(error, module, name)
    :failed
  end
  defp display(_), do: :passed
end
