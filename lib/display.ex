defmodule Display do
  @moduledoc false
  use GenServer

  alias IO.ANSI
  alias Display.{Failure, Intro, Notifications, ProgressBar}

  def start_link do
    GenServer.start_link(__MODULE__, %{clear_screen: true}, name: __MODULE__)
  end

  def init(args) do
    {:ok, args}
  end

  def disable_clear do
    GenServer.cast(__MODULE__, :disable_clear)
  end

  def handle_cast(:disable_clear, state) do
    {:noreply, %{state | clear_screen: false}}
  end

  def handle_call(:clear_screen, _from, %{clear_screen: true} = state) do
    ANSI.clear <> ANSI.home |> IO.puts()

    {:reply, :ok, state}
  end

  def handle_call(:clear_screen, _from, state) do
    {:reply, :ok, state}
  end

  def invalid_koan(koan, modules) do
    Notifications.invalid_koan(koan, modules)
    |> IO.puts()
  end

  def show_failure(failure, module, name) do
    format(failure, module, name)
    |> IO.puts()
  end

  def show_compile_error(error) do
    Failure.show_compile_error(error)
    |> IO.puts()
  end

  def congratulate do
    Notifications.congratulate()
    |> IO.puts()
  end

  def clear_screen do
    GenServer.call(__MODULE__, :clear_screen)
  end

  defp format(failure, module, name) do
    progress_bar = ProgressBar.progress_bar(Tracker.summarize())
    progress_bar_underline = String.duplicate("-", String.length(progress_bar))
    """
    #{Intro.intro(module, Tracker.visited())}
    Now meditate upon #{format_module(module)}
    #{progress_bar}
    #{progress_bar_underline}
    #{name}
    #{Failure.format_failure(failure)}
    """
  end

  defp format_module(module) do
    Module.split(module) |> List.last()
  end
end
