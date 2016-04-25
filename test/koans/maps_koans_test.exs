defmodule MapsTests do
  use ExUnit.Case
  import TestHarness

  test "Maps" do
    answers = [
      "Jon",
      {:multiple, [[:age, :last_name, :name], [27, "Jon", "Snow"]]},
      {:ok, 27},
      :error,
      {:ok, "Kayaking"},
      {:ok, 37},
      {:ok, 16},
      [:last_name, :name],
      %{:name => "Jon", :last_name => "Snow"},
      {:ok, "Baratheon"},
      %{ :name => "Jon", :last_name => "Snow"},
    ]

    test_all(Maps, answers)
  end
end
