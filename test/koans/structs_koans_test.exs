defmodule StructsTests do
  use ExUnit.Case
  import TestHarness

  test "Structs" do
    answers = [
      %Structs.Person{},
      nil,
      "Joe",
      33,
      {:ok, 22},
      %Structs.Airline{plane: %Structs.Plane{maker: :airbus}, name: "Southwest"},
      %Structs.Airline{plane: %Structs.Plane{maker: :boeing, passengers: 202}, name: "Southwest"},
      %{plane: %{maker: :cessna}, name: "Southwest"}
    ]

    test_all(Structs, answers)
  end
end
