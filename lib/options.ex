defmodule Options do
  @defaults %{
    clear_screen: false
  }

  def parse(args) do
    options = Enum.reduce(args, @defaults, fn(arg, acc) ->
      Map.merge(acc, parse_argument(arg))
    end)

    Agent.start_link(fn -> options end, name: __MODULE__)
  end

  def clear_screen? do
    Agent.get(__MODULE__, fn(options) ->
      Map.fetch!(options, :clear_screen)
    end)
  end

  def parse_argument("--clear-screen"), do: %{ clear_screen: true}
  def parse_argument(_), do: %{}
end
