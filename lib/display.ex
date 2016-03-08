defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!

  def show_failure(failure, module, name) do
    clear_screen()

    IO.puts("Now meditate upon #{format_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts(name)
    IO.puts(format_failure(failure))
  end

  def format_failure(%ExUnit.AssertionError{expr: expr}) do
    """
    #{format_cyan("Assertion failed in #{last_failure_location}")}
    #{format_red(Macro.to_string(expr))}
    """
  end

  def format_failure(error) do
    """
    #{format_cyan("Error in #{last_failure_location}")}
    #{format_error(error)}
    """
  end

  def considering(module) do
    IO.puts("Considering #{format_module(module)}...")
  end

  def clear_screen() do
    if Options.clear_screen? do
      IO.puts(ANSI.clear)
      IO.puts(ANSI.home)
    end
  end

  def last_failure_location do
    {file, line} = System.stacktrace
      |> Enum.drop_while(&in_ex_unit?/1)
      |> List.first
      |> extract_file_and_line

    "#{file}:#{line}"
  end

  defp in_ex_unit?({ExUnit.Assertions, _, _, _}), do: true
  defp in_ex_unit?(_), do: false

  defp extract_file_and_line({_, _, _, [file: file, line: line]}) do
    {file, line}
  end

  def format_compile_error(error) do
    format_error(error) |> IO.puts
  end

  def format_error(error) do
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
