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
    send parent, expand(result)
    Process.exit(self(), :kill)
  end

  def expand(:ok), do: :ok
  def expand(error) do
    {file, line} = System.stacktrace
      |> Enum.drop_while(&in_ex_unit?/1)
      |> List.first
      |> extract_file_and_line

      %{error: error, file: file, line: line}
  end

  defp in_ex_unit?({ExUnit.Assertions, _, _, _}), do: true
  defp in_ex_unit?(_), do: false

  defp extract_file_and_line({_, _, _, [file: file, line: line]}), do: {file, line}
end
