defmodule KoansHarnessTest do
  use ExUnit.Case

  test "Equalities" do
    answers = [true,
               1,
               2,
               1,
               :something]

    test_all(Equalities, answers)
  end

  test "Arithmetic" do
    answers = [
      4,
      3,
      12,
      3,
      3,
      2.5,
      2,
      1,
      4,
      1,
      2
    ]

    test_all(Arithmetic, answers)
  end

  test "Strings" do
    answers = [
      "hello",
      "hello ",
      ["hello", "world"],
      "An incredible day",
      "incredible",
      "banana",
      "banana",
      "String",
      "listen"
    ]

    test_all(Strings, answers)
  end

  test "Tuples" do
    answers = [
      3,
      {:a, 1, "hi"},
      "hi",
      {:a, "bye"},
      {:a, :new_thing, "hi"},
      {"Huey", "Dewey", "Louie"},
      {:this, :is, :awesome},
      [:this, :can, :be, :a, :list]
    ]

    test_all(Tuples, answers)
  end

  test "Lists" do
    answers = [1,
               3,
               [1, 2, :a, "b"],
               [1,2],
               [1,2,3],
               [1,3],
               ["life", "life", "life"],
               [1, 2, 3, 4, 5],
               [1, 2, 3, 4],
               [1, 4, 2, 3],
               [10, 2, 3],
               [1, 2, 3],
               [1, 2, 3, 4],
               [1, 2, 3, 4],
               {1, 2, 3},
               ["value"],
               [{1, 3, 5}, {2, 4, 6}]
               ]

    test_all(Lists, answers)
  end

  test "Maps" do
    answers = [
      "Jon",
      {:multiple, [[:age, :last_name, :name], [27, "Jon", "Snow"]]},
      {:ok, 27},
      :error,
      {:ok, "Kayaking"},
      {:ok, 37},
      {:ok, 16},
      [:last_name, :name],
      %{:name => "Jon", :last_name => "Snow"},
      {:ok, "Baratheon"},
      %{ :name => "Jon", :last_name => "Snow"}
    ]

    test_all(Maps, answers)
  end

  test "Structs" do
    answers = [
      %Structs.Person{},
      nil,
      "Joe",
      33,
      {:multiple, [33, 23]},
      22,
      {:multiple, [true, false]},
      22,
    ]

    test_all(Structs, answers)
  end

  test "Pattern Matching" do
    answers = [
      1,
      2,
      1,
      {:multiple, [1, [2,3,4]]},
      [1,2,3,4],
      3,
      "eggs, milk",
      "Honda",
      [1,2,3],
      {:multiple, ["Woof", "Meow", "Eh?",]},
      "not present"
    ]

    test_all(PatternMatching, answers)
  end

  test "Functions" do
    answers = [
      "Hello, World!",
      3,
      {:multiple, ["One and Two", "Only One"]},
      {:multiple, ["Hello Hello Hello Hello Hello ","Hello Hello "]},
      {:multiple, [:entire_list, :single_thing]},
      {:multiple, ["10 is bigger than 5", "4 is not bigger than 27"]},
      {:multiple, ["It was zero", "The length was 5"]},
      6,
      6,
      100,
      "Full Name"
    ]

    test_all(Functions, answers)
  end

  test "Enums" do
    answers = [
      3,
      2,
      {:multiple, [true, false]},
      {:multiple, [true, false]},
      {:multiple, [true, false]},
      [10,20,30],
      [1,3],
      [2],
      [1,2,3],
      [1,2,3,4,5],
      [1,2,3],
      [{1, :a}, {2, :b}, {3, :c}],
      2,
      nil,
      :no_such_element,
      6
    ]

    test_all(Enums, answers)
  end

  test "Processes" do
    answers = [
      true,
      :running,
      "hola!",
      :how_are_you?,
      {:waited_too_long, "I am inpatient"},
      false,
      {:multiple, [true, false]},
      {:exited, :random_reason},
      true,
      false,
      {:exited, :normal},
      {:exited, :normal}
      ]

    test_all(Processes, answers)
  end

  test "Tasks" do
    answers = [
      10,
      :ok,
      nil,
      nil,
      9,
      [1,4,9,16]
      ]

    test_all(Tasks, answers)
  end

  def test_all(module, answers) do
    module.all_koans
    |> Enum.zip(answers)
    |> run_all(module)
  end

  def run_all(pairs, module) do
    Enum.map(pairs, fn ({koan, answer}) -> Execute.run_koan(module, koan, [answer]) end)
  end
end
