defmodule Watcher do
  use ExFSWatch, dirs: ["lib/koans"]

  def callback(file, events)  do
    if Enum.member?(events, :modified) do
      try do
        [{mod, _} | _] = Code.load_file(file)
        Runner.run(mod)
      rescue
        e -> Display.format_compile_error(e)
      end
    end
  end
end
