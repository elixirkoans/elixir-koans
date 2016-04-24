defmodule PatternMatching do
  use Koans

  koan "One matches one" do
    assert match?(1, ___)
  end

  koan "A pattern can change" do
    a = 1
    assert a = ___
  end

  koan "A pattern can also be strict" do
    a = 1
    assert ^a = ___
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

  koan "Patterns show what you really care about" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == ___
  end

  koan "The pattern can make assertions about what it expects" do
    assert match?([1, _second, _third], ___)
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "Functions can declare what kind of arguments they accept" do
    cat = %{type: "cat"}
    dog = %{type: "dog"}
    snake = %{type: "snake"}

    assert make_noise(cat) == ___
    assert make_noise(dog) == ___
    assert make_noise(snake) == ___
  end

  koan "Errors are shaped differently than sucessful results" do
    dog = %{type: "dog"}

    result = case Map.fetch(dog, :type) do
      {:ok, value} -> value
      :error -> "not present"
    end

    assert result == ___
  end

  defmodule Animal do
    defstruct [:kind, :name]
  end

  koan "You can pattern match into the fields of a struct" do
    %Animal{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == ___
  end
end
