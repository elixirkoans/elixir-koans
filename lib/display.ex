defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!

  def show_failure(%{expr: expr}, module, name) do
    IO.puts("")
    IO.puts("Now meditate upon #{display_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts("Assertion failed in #{source_file(module)}:#{line_number(expr)}")
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

  defp display_module(module) do
    Module.split(module) |> List.last
  end

  defp display_koan(name) do
    String.replace(to_string(name), "koan: ", "")
  end
end
