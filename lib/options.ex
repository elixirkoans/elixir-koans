defmodule Options do
  @defaults %{
    clear_screen: true,
    initial_koan: Equalities,
  }

  def start(args) do
    Agent.start_link(fn -> parse(args) end, name: __MODULE__)
  end

  def clear_screen? do
    Agent.get(__MODULE__, fn(options) ->
      Map.fetch!(options, :clear_screen)
    end)
  end

  def initial_koan() do
    Agent.get(__MODULE__, fn(options) ->
      Map.fetch!(options, :initial_koan)
    end)
  end

  defp parse(args) do
    Enum.reduce(args, @defaults, fn(arg, acc) ->
      Map.merge(acc, parse_argument(arg))
    end)
  end

  def parse_argument("--koan="<>module), do: %{ initial_koan: String.to_atom("Elixir."<> module)}
  def parse_argument("--no-clear-screen"), do: %{ clear_screen: false}
  def parse_argument(_), do: %{}
end
