defmodule PatternMatching do
  @moduledoc false
  use Koans

  @intro "PatternMatching"

  koan "One matches one" do
    assert match?(1, ___)
  end

  koan "Patterns can be used to pull things apart" do
    [head | tail] = [1, 2, 3, 4]

    assert head == ___
    assert tail == ___
  end

  koan "And then put them back together" do
    head = 1
    tail = [2, 3, 4]

    assert ___ == [head | tail]
  end

  koan "Some values can be ignored" do
    [_first, _second, third, _fourth] = [1, 2, 3, 4]

    assert third == ___
  end

  koan "Strings come apart just as easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == ___
  end

  koan "Maps support partial pattern matching" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == ___
  end

  koan "Lists must match exactly" do
    assert_raise ___, fn ->
      [a, b] = [1, 2, 3]
    end
  end

  koan "So must keyword lists" do
    kw_list = [type: "car", year: 2016, make: "Honda"]
    [_type | [_year | [tuple]]] = kw_list
    assert tuple == {___, ___}
  end

  koan "The pattern can make assertions about what it expects" do
    assert match?([1, _second, _third], ___)
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "Functions perform pattern matching on their arguments" do
    cat = %{type: "cat"}
    dog = %{type: "dog"}
    snake = %{type: "snake"}

    assert make_noise(cat) == ___
    assert make_noise(dog) == ___
    assert make_noise(snake) == ___
  end

  koan "And they will only run the code that matches the argument" do
    name = fn
      "duck" -> "Donald"
      "mouse" -> "Mickey"
      _other -> "I need a name!"
    end

    assert name.("mouse") == ___
    assert name.("duck") == ___
    assert name.("donkey") == ___
  end

  koan "Errors are shaped differently than successful results" do
    dog = %{type: "barking"}

    type =
      case Map.fetch(dog, :type) do
        {:ok, value} -> value
        :error -> "not present"
      end

    assert type == ___
  end

  defmodule Animal do
    @moduledoc false
    defstruct [:kind, :name]
  end

  koan "You can pattern match into the fields of a struct" do
    %Animal{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == ___
  end

  defmodule Plane do
    @moduledoc false
    defstruct passengers: 0, maker: :boeing
  end

  def plane?(%Plane{}), do: true
  def plane?(_), do: false

  koan "...or onto the type of the struct itself" do
    assert plane?(%Plane{passengers: 417, maker: :boeing}) == ___
    assert plane?(%Animal{}) == ___
  end

  koan "Structs will even match with a regular map" do
    %{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == ___
  end

  koan "A value can be bound to a variable" do
    a = 1
    assert a == ___
  end

  koan "A variable can be rebound" do
    a = 1
    a = 2
    assert a == ___
  end

  koan "A variable can be pinned to use its value when matching instead of binding to a new value" do
    pinned_variable = 1

    example = fn
      ^pinned_variable -> "The number One"
      2 -> "The number Two"
      number -> "The number #{number}"
    end

    assert example.(1) == ___
    assert example.(2) == ___
    assert example.(3) == ___
  end

  koan "Pinning works anywhere one would match, including 'case'" do
    pinned_variable = 1

    result =
      case 1 do
        ^pinned_variable -> "same"
        other -> "different #{other}"
      end

    assert result == ___
  end

  koan "Trying to rebind a pinned variable will result in an error" do
    a = 1

    assert_raise MatchError, fn ->
      ^a = ___
    end
  end

  koan "Pattern matching works with nested data structures" do
    user = %{
      profile: %{
        personal: %{name: "Alice", age: 30},
        settings: %{theme: "dark", notifications: true}
      }
    }

    %{profile: %{personal: %{age: age}, settings: %{theme: theme}}} = user
    assert age == ___
    assert theme == ___
  end

  koan "Lists can be pattern matched with head and tail" do
    numbers = [1, 2, 3, 4, 5]

    [first, second | rest] = numbers
    assert first == ___
    assert second == ___
    assert rest == ___

    [head | _tail] = numbers
    assert head == ___
  end

  koan "Pattern matching can extract values from function return tuples" do
    divide = fn
      _, 0 -> {:error, :division_by_zero}
      x, y -> {:ok, x / y}
    end

    {:ok, result} = divide.(10, 2)
    assert result == ___

    {:error, reason} = divide.(10, 0)
    assert reason == ___
  end
end
