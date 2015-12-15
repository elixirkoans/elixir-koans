defmodule Mix.Tasks.Meditate do
  use Mix.Task
  alias IO.ANSI

  @modules [
    Equalities,
    Lists
  ]

  def run(_) do
    IO.puts("")
    Enum.take_while(@modules, fn(mod) ->
      run_module(mod) == :passed
    end)
  end

  def run_module(module) do
    IO.puts("Considering #{display_module(module)}...")

    functions = module.__info__(:functions)

    koans = Enum.map(functions, fn({name, _arity}) -> name end)
    |> Enum.filter(&koan?/1)

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
        show_failure(error, module, name)
        :failed
    end
  end

  def show_failure(%{expr: expr}, module, name) do
    IO.puts("")
    IO.puts("Now meditate upon #{display_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts("Assertion failed!")
    IO.puts(display_koan(name))
    IO.puts(format_red(Macro.to_string(expr)))
  end

  def format_red(str) do
    Enum.join([ANSI.red, str, ANSI.reset], "")
  end

  defp koan?(fun_name) do
    String.starts_with?(to_string(fun_name), "koan: ")
  end

  defp display_module(module) do
    Module.split(module) |> List.last
  end

  defp display_koan(name) do
    String.replace(to_string(name), "koan: ", "")
  end
end

