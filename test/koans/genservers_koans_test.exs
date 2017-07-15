defmodule GenServersTests do
  use ExUnit.Case
  import TestHarness

  test "GenServers" do
    answers = [
      true,
      "3kr3t!",
      "3kr3t!",
      {:multiple, ["Tribe Bicycle Co.", "CRMO Series"]},
      {:multiple, [["this", "is", "sparta"], 369, :hello_world]},
      "Hello",
      {:error, "Incorrect password!"},
      "Congrats! Your process was successfully named.",
      {:ok, "Bicycle unlocked!"},
      {:multiple, ["Bicycle unlocked!", "Incorrect password!", "Argh...Jack Sparrow's password is: Elixir"]},
    ]

    test_all(GenServers, answers)
  end
end
