defmodule Display do
  alias IO.ANSI
  @current_dir File.cwd!

  def show_failure(%{expr: expr}, module, name) do
    clear_screen()

    IO.puts("Now meditate upon #{display_module(module)}")
    IO.puts("---------------------------------------")
    IO.puts(format_cyan(display_failed_assertion(module, expr)))
    IO.puts(display_koan(name))
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

  def display_failed_assertion(module, expr) do
    file = source_file(module)
    "Assertion failed in #{file}:#{line_number(expr, in: file)}"
  end

  def format_compile_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    IO.puts(format_red(Exception.format(:error, error, trace)))
  end

  defp line_number({_, [line: line], _}, in: _), do: line
  defp line_number(expr, in: file) do
    expr
    |> to_s
    |> find_in_file(file)
    |> interpret
  end

  defp interpret({:ok, n}), do: n

  defp find_in_file(line, file) do
    File.open(file, fn(handle) ->
      IO.read(handle, :all)
      |> String.split("\n")
      |> Enum.find_index(fn(candidate) -> String.contains?(candidate, line) end)
      |> one_based
    end)
  end

  defp one_based(nil), do: "???"
  defp one_based(line), do: line + 1

  defp to_s(atom) when is_atom(atom), do: ":#{to_string(atom)}"
  defp to_s(tuple) when is_tuple(tuple) do
    elements = tuple
                 |> Tuple.to_list
                 |> Enum.map(fn(x) -> to_s(x) end)

   "{#{Enum.join(elements, ", ")}}"
  end
  defp to_s(x), do: "\"#{x}\""


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
