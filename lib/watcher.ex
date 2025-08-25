defmodule Watcher do
  @moduledoc false
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, dirs: ["lib/koans"])
  end

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    FileSystem.subscribe(watcher_pid)
    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info({:file_event, watcher_pid, {path, events}}, %{watcher_pid: watcher_pid} = state) do
    # respond to renamed as well due to that some editors use temporary files for atomic writes (ex: TextMate)
    if Enum.member?(events, :modified) || Enum.member?(events, :renamed) do
      path |> normalize |> reload
    end

    {:noreply, state}
  end

  defp reload(file) do
    if String.match?(file, Runner.koan_path_pattern()) do
      try do
        file
        |> portable_load_file
        |> Enum.map(&elem(&1, 0))
        |> Enum.find(&Runner.koan?/1)
        |> Runner.modules_to_run()
        |> Runner.run()
      rescue
        e -> Display.show_compile_error(e)
      end
    end
  end

  defp portable_load_file(file) do
    Code.compile_file(file)
  end

  defp normalize(file) do
    String.replace_suffix(file, "___jb_tmp___", "")
  end
end
