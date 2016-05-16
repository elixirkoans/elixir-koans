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
      {:multiple, ["Hello", "world"]},
      {:multiple, ["Hello", "123"]},
      ~S(#{1+1}),
    ]

    test_all(Sigils, answers)
  end
end
