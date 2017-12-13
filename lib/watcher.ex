defmodule Watcher do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [dirs: ["lib/koans"]])
  end

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    FileSystem.subscribe(watcher_pid)
    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info({:file_event, watcher_pid, {path, events}}, %{watcher_pid: watcher_pid}=state) do
    if Enum.member?(events, :modified) do
      path |> normalize |> reload
    end
    {:noreply, state}
  end

  defp reload(file) do
    if Path.extname(file) == ".ex" do
      try do
        file
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
