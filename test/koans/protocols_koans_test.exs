defmodule ProtocolsTests do
  use ExUnit.Case
  import TestHarness

  test "Protocols" do
    answers = [
      "Emily enrolled for dance",
      UndefinedFunctionError
    ]

    test_all(Protocols, answers)
  end
end
