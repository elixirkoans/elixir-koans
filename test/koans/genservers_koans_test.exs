defmodule GenServersTests do
  use ExUnit.Case
  import TestHarness

  test "GenServers" do
    answers = [
      true,
      "Hey Arnold!",
      1234,
      {:multiple, ["Tribe Bicycle Co.", "CRMO Series"]},
      ["this", "is", "sparta"],
      "Hello",
      {:error, "Incorrect password!"},
      "Congrats! Your process was successfully named.",
      {:ok, "Bicycle unlocked!"},
      {:multiple, ["Bicycle unlocked!", "Incorrect password!", "Argh...Jack Sparrow's password is: Elixir"]},
    ]

    test_all(GenServers, answers)
  end
end
