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

  def koan?(module) do
    Enum.member?(@modules, module)
  end

  def run do
    Options.initial_koan
    |>run
  end

  def run(start_module) when start_module in @modules do
    Display.clear_screen()

    start_idx = Enum.find_index(@modules, &(&1 == start_module))

    @modules
    |> Enum.drop(start_idx)
    |> Enum.take_while( &(run_module(&1) == :passed))
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
    parent = self()
    spawn fn -> exec(module, name, args, parent) end
    receive do
      :ok   -> :passed
      error -> {:failed, error, module, name}
    end
  end

  def exec(module, name, args, parent) do
    result = apply(module, name, args)
    send parent, result
    Process.exit(self(), :kill)
  end
end
