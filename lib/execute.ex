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
    case apply(module, name, args) do
      :ok  -> send(parent, :ok)
      err -> send(parent, expand(err))
    end
    Process.exit(self(), :kill)
  end

  defp expand({:error, error, {:location, file_path, line}}) do
   %{error: error, file: make_relative(file_path), line: line}
  end

  defp make_relative(path) do
    path
    |> Path.relative_to_cwd()
    |> to_string()
  end
end
