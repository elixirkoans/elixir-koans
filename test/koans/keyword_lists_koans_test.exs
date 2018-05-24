defmodule KeywordListsTests do
  use ExUnit.Case
  import TestHarness

  test "KeywordLists" do
    answers = [
      "bar",
      "bar",
      "baz",
      {:multiple, [:foo, "bar"]},
      "foo"
    ]

    test_all(KeywordLists, answers)
  end
end
