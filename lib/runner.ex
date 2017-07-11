defmodule Runner do

  def koan?(koan) do
    Keyword.has_key?(koan.__info__(:exports), :all_koans)
  end

  def modules do
    {:ok, modules} = :application.get_key(:elixir_koans, :modules)

    modules
    |> Stream.map(&(&1.module_info |> get_in([:compile, :source])))
    |> Stream.map(&to_string/1)  # Paths are charlists
    |> Stream.zip(modules)
    |> Stream.filter(fn {_path, mod} -> koan?(mod) end)
    |> Stream.map(fn {path, mod} -> {path_to_number(path), mod} end)
    |> Enum.sort_by(fn {number, _mod} -> number end)
    |> Enum.map(fn {_number, mod} -> mod end)
  end

  @koan_path_pattern ~r/lib\/koans\/(\d+)_\w+.ex$/

  def path_to_number(path) do
    [_path, number] = Regex.run(@koan_path_pattern, path)
    String.to_integer(number)
  end

  def modules_to_run, do: Options.initial_koan |> modules_to_run
  def modules_to_run(start_module), do: Enum.drop_while(modules(), &(&1 != start_module))

  def run(modules) do
    Display.clear_screen()

    modules
    |> Enum.take_while( &(run_module(&1) == :passed))
  end

  def run_module(module) do
    module
    |> Execute.run_module(&track/3)
    |> display
  end

  defp track(:passed, module, koan), do: Tracker.completed(module, koan)
  defp track(_, _, _), do: nil

  defp display({:failed, error, module, name}) do
    Display.show_failure(error, module, name)
    :failed
  end
  defp display(_), do: :passed

end
