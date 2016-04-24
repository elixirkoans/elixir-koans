defmodule PatternsTests do
  use ExUnit.Case
  use TestHarness

  test "Pattern Matching" do
    answers = [
      1,
      2,
      1,
      {:multiple, [1, [2,3,4]]},
      [1,2,3,4],
      3,
      "eggs, milk",
      "Honda",
      [1,2,3],
      {:multiple, ["Meow", "Woof", "Eh?",]},
      "dog",
      "Max",
    ]

    test_all(PatternMatching, answers)
  end
end
