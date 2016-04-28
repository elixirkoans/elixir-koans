defmodule Display do
  alias IO.ANSI

  @no_value :ex_unit_no_meaningful_value
  @progress_bar_length 30

  def invalid_koan(koan, modules) do
    koans_names = module_names(modules)
    IO.puts("Did not find koan #{name(koan)} in " <> koans_names )
  end

  defp module_names(modules) do
    modules
    |> Enum.map(&Atom.to_string/1)
    |> Enum.map(&name/1)
    |> Enum.join(", ")
    |> Colours.red
  end

  defp name("Elixir." <> module), do: module
  defp name(module), do: name(Atom.to_string(module))

  def show_failure(failure, module, name) do
    IO.puts(format(failure, module, name))
  end

  def format(failure, module, name) do
    """
    Now meditate upon #{format_module(module)}
    #{progress_bar(Tracker.summarize)}
    ----------------------------------------
    #{name}
    #{format_failure(failure)}
    """
  end

  def progress_bar(%{current: current, total: total}) do
    arrow = caluculate_progress(current, total) |> build_arrow

    "|" <> String.ljust(arrow, @progress_bar_length) <> "| #{current} of #{total}"
  end

  defp caluculate_progress(current, total) do
    round( (current/total) * @progress_bar_length)
  end

  defp build_arrow(0), do: ""
  defp build_arrow(length) do
    String.duplicate("=", length-1) <> ">"
  end

  def show_compile_error(error) do
    IO.puts("")
    format_error(error) |> IO.puts
  end

  def congratulate do
    IO.puts(Colours.green("\nYou have learned much. You must find your own path now."))
  end

  def clear_screen do
    if Options.clear_screen? do
      IO.puts(ANSI.clear)
      IO.puts(ANSI.home)
    end
  end

  defp format_failure(%{error: %ExUnit.AssertionError{expr: @no_value, message: message}, file: file, line: line}) do
    """
    #{Colours.cyan("Assertion failed in #{file}:#{line}")}
    #{Colours.red(message)}
    """
  end
  defp format_failure(%{error: %ExUnit.AssertionError{expr: expr}, file: file, line: line}) do
    format_assertion_error(expr, file, line)
  end
  defp format_failure(%{error: error, file: file, line: line}) do
    """
    #{Colours.cyan("Error in #{file}:#{line}")}
    #{format_error(error)}
    """
  end

  defp format_assertion_error(error, file, line) do
    """
    #{Colours.cyan("Assertion failed in #{file}:#{line}")}
    #{Colours.red(Macro.to_string(error))}
    """
  end

  defp format_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    Colours.red(Exception.format(:error, error, trace))
  end

  defp format_module(module) do
    Module.split(module) |> List.last
  end
end
