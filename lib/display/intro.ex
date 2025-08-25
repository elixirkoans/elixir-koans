defmodule Display.Intro do
  @moduledoc false
  alias Display.Paint

  def intro(module, modules) do
    if module in modules do
      ""
    else
      module.intro() |> show_intro()
    end
  end

  def show_intro(message) do
    (message <> "\n")
    |> Paint.green()
  end
end
