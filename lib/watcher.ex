defmodule Watcher do
  use ExFSWatch, dirs: ["lib/koans"]

  def callback(file, events)  do
    if Enum.member?(events, :modified) do
      try do
        Code.load_file(file)
          |> Enum.map(&(elem(&1, 0)))
          |> Enum.find(&Runner.koan?/1)
          |> Runner.modules_to_run
          |> Runner.run
      rescue
        e -> Display.show_compile_error(e)
      end

      if Tracker.complete? do
        Display.congratulate
        exit(:normal)
      end
    end
  end
end
