defmodule Runner do
  @modules [
    Equalities,
    Strings,
    Lists,
    Maps,
    Functions,
    Enums,
    Arithmetic,
    Structs,
    PatternMatching,
    Processes,
    Tasks
  ]

  def run do
    run(Equalities)
  end

  def run(start_module) do
    Display.clear_screen()
    start_idx = Enum.find_index(@modules, &(&1 == start_module))
    Enum.drop(@modules, start_idx)
    |> Enum.take_while(fn(mod) ->
      run_module(mod) == :passed
    end)
  end

  def run_module(module) do
    Display.considering(module)

    koans = module.all_koans
    passed = Enum.take_while(koans, fn(name) ->
      run_koan(module, name) == :passed
    end)

    if Enum.count(koans) == Enum.count(passed) do
      :passed
    else
      :failed
    end
  end

  def run_koan(module, name) do
    case apply(module, name, []) do
      :ok   -> :passed
      error ->
        Display.show_failure(error, module, name)
        :failed
    end
  end
end
