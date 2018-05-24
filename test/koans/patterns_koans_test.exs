defmodule PatternsTests do
  use ExUnit.Case
  import TestHarness

  test "Pattern Matching" do
    answers = [
      1,
      {:multiple, [1, [2, 3, 4]]},
      [1, 2, 3, 4],
      3,
      "eggs, milk",
      "Honda",
      MatchError,
      {:multiple, [:make, "Honda"]},
      [1, 2, 3],
      {:multiple, ["Meow", "Woof", "Eh?"]},
      {:multiple, ["Mickey", "Donald", "I need a name!"]},
      "dog",
      "Max",
      {:multiple, [true, false]},
      "Max",
      1,
      2,
      {:multiple, ["The number One", "The number Two", "The number 3"]},
      "same",
      2
    ]

    test_all(PatternMatching, answers)
  end
end
