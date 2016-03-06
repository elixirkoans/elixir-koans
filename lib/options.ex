defmodule Options do

  def parse([]), do: defaults
  def parse(args) do
    Enum.reduce(args, defaults, fn(arg, acc) ->
      Map.merge(acc, parse_argument(arg))
    end)
  end

  def parse_argument("--clear-screen"), do: %{ clear_screen: true}
  def parse_argument(_), do: %{}

  defp defaults do
    %{ clear_screen: false}
  end
end
