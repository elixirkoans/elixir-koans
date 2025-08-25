defmodule ElixirKoans do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      %{id: Display, start: {Display, :start_link, []}},
      %{id: Tracker, start: {Tracker, :start_link, []}},
      %{id: Runner, start: {Runner, :start_link, []}},
      %{id: Watcher, start: {Watcher, :start_link, []}}
    ]

    opts = [strategy: :one_for_one, name: ElixirKoans.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
