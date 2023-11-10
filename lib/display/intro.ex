defmodule Display.Intro do
  @moduledoc false
  alias Display.Paint

  def intro(module, modules) do
    if module in modules do
      ""
    else
      show_intro(module.intro)
    end
  end

  def show_intro(message) do
    (message <> "\n")
    |> Paint.green()
  end
end
