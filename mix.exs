defmodule Koans.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_koans,
     version: "0.0.1",
     elixir: "~> 1.1",
     deps: deps]
  end

  def application do
    [applications: [:exfswatch, :logger]]
  end

  defp deps do
    [{:exfswatch, "~> 0.1.0"}]
  end
end
