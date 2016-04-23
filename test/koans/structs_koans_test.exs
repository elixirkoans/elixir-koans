defmodule StructsTests do
  use ExUnit.Case
  use TestHarness

  test "Structs" do
    answers = [
      %Structs.Person{},
      nil,
      "Joe",
      33,
      {:multiple, [true, false]},
      22,
    ]

    test_all(Structs, answers)
  end
end
