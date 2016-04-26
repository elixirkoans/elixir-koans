defmodule StructsTests do
  use ExUnit.Case
  import TestHarness

  test "Structs" do
    answers = [
      %Structs.Person{},
      nil,
      "Joe",
      33,
      {:multiple, [true, false]},
      {:ok, 22},
    ]

    test_all(Structs, answers)
  end
end
