defmodule Watcher do
  use ExFSWatch, dirs: ["lib/koans"]

  def callback(file, events)  do
    if Enum.member?(events, :modified) do
      [{mod, _}] = Code.load_file(file)
      Runner.run(mod)
    end
  end
end
