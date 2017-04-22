defmodule AtomsTests do
  use ExUnit.Case
  import TestHarness

  test "Atoms" do
    answers = [
      :human,
      {:multiple, [true, true, true, false]},
      {:multiple, [true, nil]}
    ]

    test_all(Atoms, answers)
  end
end
