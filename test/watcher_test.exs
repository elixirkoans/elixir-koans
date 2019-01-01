defmodule WatcherTest do
  use ExUnit.Case

  test "watches for changes" do
    parent = self()
    {:ok, path} = Briefly.create(directory: true)
    {:ok, pid} = Watcher.start_link(%{folder_to_watch: path, handler: fn(file) -> send parent, {:file, file} end})

    File.write!(Path.join(path, "test.exs"), "Some Text")

    assert_receive {:file, "foo"}, 1_000
  end
end
