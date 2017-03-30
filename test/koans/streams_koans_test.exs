defmodule StreamsTests do
  use ExUnit.Case
  import TestHarness

  test "Streams" do
    answers = [
      Stream,
      [2, 3, 4],
      ["I computed: 1"],
    ]

    test_all(Streams, answers)
  end
end
