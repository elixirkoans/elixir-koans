defmodule TupleTests do
  use ExUnit.Case
  import TestHarness

  test "Tuples" do
    answers = [
      {:a, 1, "hi"},
      3,
      "hi",
      {:a, "bye"},
      {:a, :new_thing, "hi"},
      {"Huey", "Dewey", "Louie"},
      {:this, :is, :awesome},
      [:this, :can, :be, :a, :list]
    ]

    test_all(Tuples, answers)
  end
end
