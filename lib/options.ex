defmodule Options do
  @defaults %{
    initial_koan: Equalities,
  }

  def start(args) do
    Agent.start_link(fn -> parse(args) end, name: __MODULE__)
  end

  def initial_koan() do
    Agent.get(__MODULE__, &Map.fetch!(&1, :initial_koan))
  end

  defp parse(args) do
    Enum.reduce(args, @defaults, fn(arg, acc) ->
      Map.merge(acc, parse_argument(arg))
    end)
  end

  def parse_argument("--koan="<>module), do: %{ initial_koan: String.to_atom("Elixir."<> module)}
  def parse_argument(_), do: %{}
end
