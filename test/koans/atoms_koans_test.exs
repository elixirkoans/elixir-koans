defmodule AtomsTests do
  use ExUnit.Case
  import TestHarness

  test "Atoms" do
    answers = [
      :human,
      {:multiple, [:atomized, "stringified"]},
      {:multiple, [true, true, true, false]},
      {:multiple, [true, String, "HELLO"]},
      {:multiple, [true, [1,2,3]]},
    ]

    test_all(Atoms, answers)
  end
end
