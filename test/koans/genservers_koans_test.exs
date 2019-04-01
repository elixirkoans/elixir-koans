defmodule GenServersTests do
  use ExUnit.Case
  import TestHarness

  test "GenServers" do
    answers = [
      true,
      "3kr3t!",
      {:multiple, ["Apple Inc.", "MacBook Pro"]},
      {:multiple, [["2.9 GHz Intel Core i5"], 8192, :intel_iris_graphics]},
      "73x7!n9",
      {:error, "Incorrect password!"},
      "Congrats! Your process was successfully named.",
      {:ok, "Laptop unlocked!"},
      {:multiple, ["Laptop unlocked!", "Incorrect password!", "Jack Sparrow"]}
    ]

    test_all(GenServers, answers)
  end
end
