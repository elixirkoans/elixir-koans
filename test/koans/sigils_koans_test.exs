defmodule SigilsTests do
  use ExUnit.Case
  import TestHarness

  test "Sigils" do
    answers = [
      "This is a string",
      ~S("Welcome to the jungle", they said.),
      true,
      "1 + 1 = 2",
      ~S(1 + 1 = #{1+1}),
      ["Hello", "world"],
      ["Hello", "123"],
      ["Hello", ~S(#{1+1})]
    ]

    test_all(Sigils, answers)
  end
end
