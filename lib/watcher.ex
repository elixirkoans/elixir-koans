defmodule Watcher do
  use GenServer

  def start_link() do
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
    if Path.extname(file) == ".ex" do
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

  # Elixir 1.7 deprecates Code.load_file in favor of Code.compile_file. In
  # order to avoid the depecation warnings while maintaining backwards
  # compatibility, we check the sytem version and execute conditionally.
  defp portable_load_file(file) do
    if Version.match?(System.version(), "~> 1.7") do
      Code.compile_file(file)
    else
      Code.load_file(file)
    end
  end

  defp normalize(file) do
    String.replace_suffix(file, "___jb_tmp___", "")
  end
end
