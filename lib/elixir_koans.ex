defmodule ElixirKoans do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Display, []},
      {Tracker, []},
      {Runner, []},
      {Watcher, []}
    ]

    opts = [strategy: :one_for_one, name: ElixirKoans.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
