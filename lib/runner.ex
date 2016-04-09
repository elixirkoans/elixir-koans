defmodule Runner do
  @modules [
    Equalities,
    Arithmetic,
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
  ]

  def koan?(koan), do: Enum.member?(@modules, koan)

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
    Display.considering(module)
    case Execute.run_module(module) do
        {:failed, error, module, name} -> Display.show_failure(error, module, name)
                                          :failed
        _ -> :passed
    end
  end
end
