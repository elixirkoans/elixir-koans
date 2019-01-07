defmodule Runner do
  use GenServer

  def koan?(koan) do
    case Code.ensure_loaded(koan) do
      {:module, _} -> Keyword.has_key?(koan.__info__(:functions), :all_koans)
      _ -> false
    end
  end

  def modules do
    {:ok, modules} = :application.get_key(:elixir_koans, :modules)

    modules
    |> Stream.map(&(&1.module_info |> get_in([:compile, :source])))
    # Paths are charlists
    |> Stream.map(&to_string/1)
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

  def modules_to_run(start_module), do: Enum.drop_while(modules(), &(&1 != start_module))

  def init(args) do
    {:ok, args}
  end

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:run, modules}, _) do
    flush()
    send(self(), :run_modules)
    {:noreply, modules}
  end

  def handle_info(:run_modules, []) do
    {:noreply, []}
  end

  def handle_info(:run_modules, [module | rest]) do
    Display.clear_screen()

    case run_module(module) do
      :passed ->
        send(self(), :run_modules)
        {:noreply, rest}

      _ ->
        {:noreply, []}
    end
  end

  def run(modules) do
    GenServer.cast(__MODULE__, {:run, modules})
  end

  defp run_module(module) do
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

  defp flush do
    receive do
      _ -> flush()
    after
      0 -> :ok
    end
  end
end
