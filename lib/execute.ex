defmodule Execute do
  def run_module(module, callback \\ fn _result, _module, _koan -> nil end) do
    Enum.reduce_while(module.all_koans, :passed, fn koan, _ ->
      module
      |> run_koan(koan)
      |> hook(module, koan, callback)
      |> continue?
    end)
  end

  defp hook(result, module, koan, callback) do
    callback.(result, module, koan)
    result
  end

  defp continue?(:passed), do: {:cont, :passed}
  defp continue?(result), do: {:halt, result}

  def run_koan(module, name, args \\ []) do
    parent = self()
    spawn(fn -> exec(module, name, args, parent) end)
    listen_for_result(module, name)
  end

  def listen_for_result(module, name) do
    receive do
      :ok -> :passed
      %{error: _} = failure -> {:failed, failure, module, name}
      _ -> listen_for_result(module, name)
    end
  end

  defp exec(module, name, args, parent) do
    result = apply(module, name, args)
    send(parent, expand(result, module))
    Process.exit(self(), :kill)
  end

  defp expand(:ok, _), do: :ok

  defp expand({:error, stacktrace, exception}, module) do
    {file, line} =
      stacktrace
      |> Enum.drop_while(&(!in_koan?(&1, module)))
      |> List.first()
      |> extract_file_and_line

    %{error: exception, file: file, line: line}
  end

  defp in_koan?({module, _, _, _}, koan), do: module == koan

  defp extract_file_and_line({_, _, _, [file: file, line: line]}) do
    {file, line}
  end
end
