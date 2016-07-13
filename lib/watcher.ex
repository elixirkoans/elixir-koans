defmodule Watcher do
  use ExFSWatch, dirs: ["lib/koans"]

  def callback(file, events)  do
    if Enum.member?(events, :modified) do
      reload(file)

      if Tracker.complete? do
        Display.congratulate
        exit(:normal)
      end
    end
  end

  defp reload(file) do
    if Path.extname(file) == ".ex" do
      try do
        file
        |> normalize
        |> Code.load_file
        |> Enum.map(&(elem(&1, 0)))
        |> Enum.find(&Runner.koan?/1)
        |> Runner.modules_to_run
        |> Runner.run
      rescue
        e -> Display.show_compile_error(e)
      end
    end
  end

  defp normalize(file) do
    String.replace_suffix(file, "___jb_tmp___", "")
  end
end
