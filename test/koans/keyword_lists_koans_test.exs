defmodule KeywordListsTests do
  use ExUnit.Case
  import TestHarness

  test "KeywordLists" do
    answers = [
      "bar",
      "bar",
      "baz",
      {:multiple, [:foo, "bar"]},
      "foo",
      "GOOD",
      :good,
      {:multiple, [:this, :that]},
    ]

    test_all(KeywordLists, answers)
  end
end
