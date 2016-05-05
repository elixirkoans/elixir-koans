defmodule AtomsTests do
  use ExUnit.Case
  import TestHarness

  test "Atoms" do
    answers = [
      :human,
      {:multiple, [:atomized, "stringified"]},
      {:multiple, [true, true, true, false]},
      true,
      "HELLO",
    ]

    test_all(Atoms, answers)
  end
end
