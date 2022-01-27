defmodule ProtocolsTests do
  use ExUnit.Case
  import TestHarness

  test "Protocols" do
    answers = [
      {:multiple, ["Andre played violin", "Darcy performed ballet"]},
      "Artist showed performance",
      Protocol.UndefinedError
    ]

    test_all(Protocols, answers)
  end
end
