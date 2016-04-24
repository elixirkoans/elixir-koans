defmodule EqualitiesTests do
  use ExUnit.Case
  use TestHarness

  test "Equalities" do
    answers = [
      true,
      false,
      1,
      2,
      1,
      4,
      2,
    ]

    test_all(Equalities, answers)
  end
end
