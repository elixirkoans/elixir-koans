defmodule Display.Paint do
  def red(str), do: painter().red(str)
  def cyan(str), do: painter().cyan(str)
  def green(str), do: painter().green(str)
  def yellow(str), do: painter().yellow(str)

  defp painter do
    case Mix.env() do
      :test -> Display.Uncoloured
      _ -> Display.Colours
    end
  end
end

defmodule Display.Colours do
  alias IO.ANSI

  def red(str), do: colourize(ANSI.red(), str)
  def cyan(str), do: colourize(ANSI.cyan(), str)
  def green(str), do: colourize(ANSI.green(), str)
  def yellow(str), do: colourize(ANSI.yellow(), str)

  defp colourize(color, message) do
    Enum.join([color, message, ANSI.reset()], "")
  end
end

defmodule Display.Uncoloured do
  def red(str), do: str
  def cyan(str), do: str
  def green(str), do: str
  def yellow(str), do: str
end
