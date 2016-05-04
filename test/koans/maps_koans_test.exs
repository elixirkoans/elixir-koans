defmodule MapsTests do
  use ExUnit.Case
  import TestHarness

  test "Maps" do
    answers = [
      "Jon",
      {:ok, 27},
      :error,
      {:ok, "Kayaking"},
      {:ok, 37},
      {:ok, 16},
      false,
      %{:name => "Jon", :last_name => "Snow"},
      {:ok, "Baratheon"},
      %{ :name => "Jon", :last_name => "Snow"},
    ]

    test_all(Maps, answers)
  end
end
