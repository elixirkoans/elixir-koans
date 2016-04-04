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

  def run do
    Options.initial_koan
    |>run
  end

  def run(start_module) when start_module in @modules do
    Display.clear_screen()
    start_idx = Enum.find_index(@modules, &(&1 == start_module))
    Enum.drop(@modules, start_idx)
    |> Enum.take_while(fn(mod) ->
      run_module(mod) == :passed
    end)
  end
  def run(koan), do: Display.invalid_koan(koan, @modules)

  def run_module(module) do
    Display.considering(module)

    koans = module.all_koans
    passed = Enum.take_while(koans, fn(name) ->
      case run_koan(module, name) do
        :passed -> true
        {:failed, error, module, name} -> Display.show_failure(error, module, name)
                                          false
      end
    end)

    if Enum.count(koans) == Enum.count(passed) do
      :passed
    else
      :failed
    end
  end

  def run_koan(module, name, args \\ []) do
    case apply(module, name, args) do
      :ok   -> :passed
      error -> {:failed, error, module, name}
    end
  end
end
