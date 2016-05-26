defmodule ProtocolsTests do
  use ExUnit.Case
  import TestHarness

  test "Protocols" do
    answers = [
      {:multiple, ["Emily enrolled at secondary school", "Darcy enrolled for ballet"]},
      Protocol.UndefinedError
    ]

    test_all(Protocols, answers)
  end
end
