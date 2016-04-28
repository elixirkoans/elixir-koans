defmodule Colours do
  alias IO.ANSI

  def red(str), do: colourize(ANSI.red, str)

  def cyan(str), do: colourize(ANSI.cyan, str)

  def green(str), do: colourize(ANSI.green, str)

  defp colourize(color, message) do
    Enum.join([color, message, ANSI.reset], "")
  end
end
