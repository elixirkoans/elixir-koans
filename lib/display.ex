defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!

  def show_failure(%{expr: expr}, module, name) do
    clear_screen()

    IO.puts("Now meditate upon #{display_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts(format_cyan(last_failure_location))
    IO.puts(name)
    IO.puts(format_red(Macro.to_string(expr)))
  end

  def considering(module) do
    IO.puts("Considering #{display_module(module)}...")
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

    "Assertion failed in #{file}:#{line}"
  end

  defp in_ex_unit?({ExUnit.Assertions, _, _, _}), do: true
  defp in_ex_unit?(_), do: false

  defp extract_file_and_line({_, _, _, [file: file, line: line]}) do
    {file, line}
  end

  def format_compile_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    IO.puts(format_red(Exception.format(:error, error, trace)))
  end

  defp format_red(str) do
    Enum.join([ANSI.red, str, ANSI.reset], "")
  end

  defp format_cyan(str) do
    Enum.join([ANSI.cyan, str, ANSI.reset], "")
  end

  defp display_module(module) do
    Module.split(module) |> List.last
  end
end
