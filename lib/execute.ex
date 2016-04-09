defmodule Execute do
  def run_module(module) do
    run_until_failure(module, &run_koan/2)
  end

  def run_until_failure(module, callback) do
    Enum.reduce_while(module.all_koans, :passed, fn(it, _acc) ->
      result = callback.(module, it)
      if result == :passed do
        {:cont, :passed}
      else
        {:halt, result}
      end
    end)
  end

  def run_koan(module, name, args \\ []) do
    parent = self()
    spawn fn -> exec(module, name, args, parent) end
    receive do
      :ok   -> :passed
      error -> {:failed, error, module, name}
    end
  end

  def exec(module, name, args, parent) do
    result = apply(module, name, args)
    send parent, expand(result)
    Process.exit(self(), :kill)
  end

  def expand(:ok), do: :ok
  def expand(error) do
    {file, line} = System.stacktrace
      |> Enum.drop_while(&in_ex_unit?/1)
      |> List.first
      |> extract_file_and_line

      %{error: error, file: file, line: line}
  end

  defp in_ex_unit?({ExUnit.Assertions, _, _, _}), do: true
  defp in_ex_unit?(_), do: false

  defp extract_file_and_line({_, _, _, [file: file, line: line]}) do
   {file, line}
  end
end
