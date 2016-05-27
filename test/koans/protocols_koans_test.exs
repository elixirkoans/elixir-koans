defmodule ProtocolsTests do
  use ExUnit.Case
  import TestHarness

  test "Protocols" do
    answers = [
      {:multiple, ["Andre signed up for violin", "Darcy enrolled for ballet"]},
      "Pupil enrolled at school",
      Protocol.UndefinedError
    ]

    test_all(Protocols, answers)
  end
end
