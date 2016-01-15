defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!

  def show_failure(%{expr: expr}, module, name) do
    IO.puts("")
    IO.puts("Now meditate upon #{display_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts(format_cyan(display_failed_assertion(module, expr)))
    IO.puts(display_koan(name))
    IO.puts(format_red(Macro.to_string(expr)))
  end

  def considering(module) do
    IO.puts("Considering #{display_module(module)}...")
  end

  def before_run do
    IO.puts("")
    IO.puts("")
  end

  def display_failed_assertion(module, expr) do
    "Assertion failed in #{source_file(module)}:#{line_number(expr)}"
  end

  def format_compile_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    IO.puts(format_red(Exception.format(:error, error, trace)))
  end

  defp line_number({_, [line: line], _}) do
    line
  end

  defp source_file(module) do
    module.__info__(:compile)
    |> Dict.get(:source)
    |> Path.relative_to(@current_dir)
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

  defp display_koan(name) do
    String.replace(to_string(name), Koans.prefix, "")
  end
end
