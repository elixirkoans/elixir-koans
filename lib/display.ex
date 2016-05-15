defmodule Display do
  alias IO.ANSI
  alias Display.ProgressBar
  alias Display.Intro
  alias Display.Failure
  alias Display.Notifications

  def invalid_koan(koan, modules) do
    Notifications.invalid_koan(koan, modules)
    |> IO.puts
  end

  def show_failure(failure, module, name) do
    format(failure, module, name)
    |> IO.puts
  end

  def format(failure, module, name) do
    """
    #{Intro.intro(module, Tracker.visited)}
    Now meditate upon #{format_module(module)}
    #{ProgressBar.progress_bar(Tracker.summarize)}
    ----------------------------------------
    #{name}
    #{Failure.format_failure(failure)}
    """
  end

  def show_compile_error(error) do
    Failure.show_compile_error(error)
    |> IO.puts
  end

  def congratulate do
    Notifications.congratulate
    |> IO.puts
  end

  def clear_screen do
    if Options.clear_screen? do
      IO.puts(ANSI.clear)
      IO.puts(ANSI.home)
    end
  end

  defp format_module(module) do
    Module.split(module) |> List.last
  end
end
