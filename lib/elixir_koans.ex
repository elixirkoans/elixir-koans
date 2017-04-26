defmodule ElixirKoans do
  use Application
  alias Options

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Display, []),
      worker(Tracker, [])
    ]

    opts = [strategy: :one_for_one, name: ElixirKoans.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
