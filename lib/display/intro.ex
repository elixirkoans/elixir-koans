defmodule Display.Intro do
  def intro(module, modules) do
    if not module in modules do
      show_intro(module.intro)
    else
      ""
    end
  end

  def show_intro(message) do
    message <> "\n"
    |> Colours.green
  end
end
