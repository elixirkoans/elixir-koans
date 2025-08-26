defmodule FunctionsTests do
  use ExUnit.Case
  import TestHarness

  test "Functions" do
    answers = [
      "Hello, World!",
      3,
      {:multiple, ["One and Two", "Only One"]},
      {:multiple, ["Hello Hello Hello ", "Hello Hello "]},
      {:multiple, [:entire_list, :single_thing]},
      {:multiple, ["10 is bigger than 5", "4 is not bigger than 27"]},
      {:multiple, ["The number was zero", "The number was 5"]},
      6,
      6,
      "Hi, Foo!",
      ["foo", "foo", "foo"],
      {:multiple, ["Success is no accident", "You just lost the game"]},
      100,
      1000,
      "Full Name",
      {:multiple, [24, "hello_world"]},
      {:multiple, ["GOOD", "good"]},
      {:multiple, [12, 5]}
    ]

    test_all(Functions, answers)
  end
end
