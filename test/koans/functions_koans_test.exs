defmodule FunctionsTests do
  use ExUnit.Case
  import TestHarness

  test "Functions" do
    answers = [
      "Hello, World!",
      3,
      {:multiple, ["One and Two", "Only One"]},
      {:multiple, ["Hello Hello Hello Hello Hello ","Hello Hello "]},
      {:multiple, [:entire_list, :single_thing]},
      {:multiple, ["10 is bigger than 5", "4 is not bigger than 27"]},
      {:multiple, ["The number was zero", "The number was 5"]},
      6,
      6,
      "Hello, Foo!",
      ["foo", "foo", "foo"],
      100,
      1000,
      "Full Name",
    ]

    test_all(Functions, answers)
  end
end
