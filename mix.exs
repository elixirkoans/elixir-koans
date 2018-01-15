defmodule Koans.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_koans,
     version: "0.0.1",
     elixir: ">= 1.3.0 and < 2.0.0",
     elixirc_paths: elixirc_path(Mix.env),
     deps: deps()]
  end

  def application do
    [mod: {ElixirKoans, []},
     applications: [:file_system, :logger]]
  end

  defp deps do
    [{:file_system, "~> 0.2"}]
  end

  defp elixirc_path(:test), do: ["lib/", "test/support"]
  defp elixirc_path(_), do: ["lib/"]
end
