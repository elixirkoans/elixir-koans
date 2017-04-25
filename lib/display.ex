defmodule Display do
  use GenServer

  alias IO.ANSI
  alias Display.{ProgressBar, Intro, Failure, Notifications}

  def start_link do
    GenServer.start_link(__MODULE__, %{clear_screen: true}, name: __MODULE__)
  end

  def disable_clear do
    GenServer.cast(__MODULE__, :disable_clear)
  end

  def handle_cast(:disable_clear, state) do
    {:noreply, %{state | clear_screen: false}}
  end

  def handle_cast({:invalid, koan, modules}, state) do
    Notifications.invalid_koan(koan, modules)
    |> IO.puts

    {:noreply, state}
  end

  def handle_cast({:show_failure, failure, module, name}, state) do
    format(failure, module, name)
    |> IO.puts

    {:noreply, state}
  end

  def handle_cast({:show_compile_error, error}, state) do
    Failure.show_compile_error(error)
    |> IO.puts

    {:noreply, state}
  end

  def handle_cast(:congratulate, state) do
    Notifications.congratulate
    |> IO.puts

    {:noreply, state}
  end

  def handle_cast(:clear_screen, state = %{clear_screen: true}) do
    IO.puts(ANSI.clear)
    IO.puts(ANSI.home)

    {:noreply, state}
  end
  def handle_cast(:clear_screen, state) do
    {:noreply, state}
  end

  def invalid_koan(koan, modules) do
    GenServer.cast(__MODULE__, {:invalid, koan, modules})
  end

  def show_failure(failure, module, name) do
    GenServer.cast(__MODULE__, {:show_failure, failure, module, name})
  end

  def show_compile_error(error) do
    GenServer.cast(__MODULE__, {:show_compile_error, error})
  end

  def congratulate do
    GenServer.cast(__MODULE__, :congratulate)
  end

  def clear_screen do
    GenServer.cast(__MODULE__, :clear_screen)
  end

  defp format(failure, module, name) do
    """
    #{Intro.intro(module, Tracker.visited)}
    Now meditate upon #{format_module(module)}
    #{ProgressBar.progress_bar(Tracker.summarize)}
    ----------------------------------------
    #{name}
    #{Failure.format_failure(failure)}
    """
  end

  defp format_module(module) do
    Module.split(module) |> List.last
  end
end
