defmodule PatternMatching do
  use Koans

  @intro "PatternMatching"

  koan "One matches one" do
    assert match?(1, 1)
  end

  koan "Patterns can be used to pull things apart" do
    [head | tail] = [1, 2, 3, 4]

    assert head == 1
    assert tail == [2, 3, 4]
  end

  koan "And then put them back together" do
    head = 1
    tail = [2, 3, 4]

    assert [1, 2, 3, 4] == [head | tail]
  end

  koan "Some values can be ignored" do
    [_first, _second, third, _fourth] = [1, 2, 3, 4]

    assert third == 3
  end

  koan "Strings come apart just as easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == "eggs, milk"
  end

  koan "Maps support partial pattern matching" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == "Honda"
  end

  koan "Lists must match exactly" do
    assert_raise MatchError, fn ->
      [a, b] = [1, 2, 3]
    end
  end

  koan "So does the keyword lists" do
    kw_list = [type: "car", year: 2016, make: "Honda"]
    [_type | [_year | [tuple]]] = kw_list
    assert tuple == {:make, "Honda"}
  end

  koan "The pattern can make assertions about what it expects" do
    assert match?([1, _second, _third], [1, nil, nil])
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "Functions perform pattern matching on their arguments" do
    cat = %{type: "cat"}
    dog = %{type: "dog"}
    snake = %{type: "snake"}

    assert make_noise(cat) == "Meow"
    assert make_noise(dog) == "Woof"
    assert make_noise(snake) == "Eh?"
  end

  koan "And they will only run the code that matches the argument" do
    name = fn
      "duck" -> "Donald"
      "mouse" -> "Mickey"
      _other -> "I need a name!"
    end

    assert name.("mouse") == "Mickey"
    assert name.("duck") == "Donald"
    assert name.("donkey") == "I need a name!"
  end

  koan "Errors are shaped differently than successful results" do
    dog = %{type: "dog"}

    result =
      case Map.fetch(dog, :type) do
        {:ok, value} -> value
        :error -> "not present"
      end

    assert result == "dog"
  end

  defmodule Animal do
    defstruct [:kind, :name]
  end

  koan "You can pattern match into the fields of a struct" do
    %Animal{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == "Max"
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end

  def plane?(%Plane{}), do: true
  def plane?(_), do: false

  koan "...or onto the type of the struct itself" do
    assert plane?(%Plane{passengers: 417, maker: :boeing}) == true
    assert plane?(%Animal{}) == false
  end

  koan "Structs will even match with a regular map" do
    %{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == "Max"
  end

  koan "A value can be bound to a variable" do
    a = 1
    assert a == 1
  end

  koan "A variable can be rebound" do
    a = 1
    a = 2
    assert a == 2
  end

  koan "A variable can be pinned to use its value when matching instead of binding to a new value" do
    pinned_variable = 1

    example = fn
      ^pinned_variable -> "The number One"
      2 -> "The number Two"
      number -> "The number #{number}"
    end

    assert example.(1) == "The number One"
    assert example.(2) == "The number Two"
    assert example.(3) == "The number 3"
  end

  koan "Pinning works anywhere one would match, including 'case'" do
    pinned_variable = 1

    result =
      case 1 do
        ^pinned_variable -> "same"
        other -> "different #{other}"
      end

    assert result == "same"
  end

  koan "Trying to rebind a pinned variable will result in an error" do
    a = 1

    assert_raise MatchError, fn ->
      ^a = 2
    end
  end
end
