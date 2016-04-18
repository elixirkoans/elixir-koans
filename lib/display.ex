defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!
  @no_value :ex_unit_no_meaningful_value

  def invalid_koan(koan, modules) do
    koans_names = module_names(modules)
    IO.puts("Did not find koan #{name(koan)} in " <> koans_names )
    exit(:normal)
  end

  defp module_names(modules) do
    modules
    |> Enum.map(&Atom.to_string/1)
    |> Enum.map(&name/1)
    |> Enum.join(", ")
    |> format_red
  end

  defp name("Elixir." <> module), do: module
  defp name(module), do: name(Atom.to_string(module))

  def show_failure(failure, module, name) do
    IO.puts("Now meditate upon #{format_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts(name)
    IO.puts(format_failure(failure))
  end

  def show_compile_error(error) do
    IO.puts("")
    format_error(error) |> IO.puts
  end

  def considering(module) do
    IO.puts("Considering #{format_module(module)}...")
    module
  end

  def clear_screen do
    if Options.clear_screen? do
      IO.puts(ANSI.clear)
      IO.puts(ANSI.home)
    end
  end

  defp format_failure(%{error: %ExUnit.AssertionError{expr: @no_value, message: message}, file: file, line: line}) do
    format_assertion_error(message, file, line)
  end

  defp format_failure(%{error: %ExUnit.AssertionError{expr: expr}, file: file, line: line}) do
    format_assertion_error(expr, file, line)
  end

  defp format_assertion_error(error, file, line) do
    """
    #{format_cyan("Assertion failed in #{file}:#{line}")}
    #{format_red(Macro.to_string(error))}
    """
  end

  defp format_failure(%{error: error, file: file, line: line}) do
    """
    #{format_cyan("Error in #{file}:#{line}")}
    #{format_error(error)}
    """
  end

  defp format_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    format_red(Exception.format(:error, error, trace))
  end

  defp format_red(str) do
    Enum.join([ANSI.red, str, ANSI.reset], "")
  end

  defp format_cyan(str) do
    Enum.join([ANSI.cyan, str, ANSI.reset], "")
  end

  defp format_module(module) do
    Module.split(module) |> List.last
  end
end
