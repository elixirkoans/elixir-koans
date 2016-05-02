defmodule PatternsTests do
  use ExUnit.Case
  import TestHarness

  test "Pattern Matching" do
    answers = [
      1,
      1,
      2,
      2,
      {:multiple, [1, [2,3,4]]},
      [1,2,3,4],
      3,
      "eggs, milk",
      "Honda",
      [1,2,3],
      {:multiple, ["Meow", "Woof", "Eh?"]},
      {:multiple, ["Mickey", "Donald", "I need a name!"]},
      "dog",
      "Max",
    ]

    test_all(PatternMatching, answers)
  end
end
