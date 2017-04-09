defmodule GenServersTests do
  use ExUnit.Case
  import TestHarness

  test "GenServers" do
    answers = [
      true,
      true,
      [],
      [5, 3, 1],
      :ok
    ]

    test_all(GenServers, answers)
  end
end
