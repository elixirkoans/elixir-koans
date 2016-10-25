defmodule Koans.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_koans,
     version: "0.0.1",
     elixir: ">= 1.2.1 and < 1.4.0",
     elixirc_paths: elixirc_path(Mix.env),
     deps: deps]
  end

  def application do
    [applications: [:exfswatch, :logger]]
  end

  defp deps do
    [{:exfswatch, "~> 0.1.1"}]
  end

  defp elixirc_path(:test), do: ["lib/", "test/support"]
  defp elixirc_path(_), do: ["lib/"]
end
