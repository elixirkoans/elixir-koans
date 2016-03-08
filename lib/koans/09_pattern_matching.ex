defmodule PatternMatching do
  use Koans

  koan "one matches one" do
    assert match?(1, 1)
  end

  koan "patterns can be used to pull things apart" do
    [head | tail] = [1,2,3,4]

    assert head == 1
    assert tail == [2,3,4]
  end

  koan "or put them back together" do
    head = 1
    tail = [2,3,4]

    assert [1,2,3,4] == [head | tail]
  end

  koan "Some values can be irrelevant" do
    [_first, _second, third, _fourth] = [1,2,3,4]

    assert third == 3
  end

  koan "strings come apart just a easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == "eggs, milk"
  end

  koan "patterns show what you really care about" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == "Honda"
  end

  koan "the pattern can make assertions about what it expects" do
    the_list = [1, 2, 3]

    assert match?([1, _, _], the_list)
    refute match?([2, _, _], the_list)
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "functions can declare what kind of arguments they accept" do
    dog = %{type: "dog", legs: 4, age: 9, color: "brown"}
    cat = %{type: "cat", legs: 4, age: 3, color: "grey"}
    snake = %{type: "snake", legs: 0, age: 20, color: "black"}

    assert make_noise(dog) == "Woof"
    assert make_noise(cat) == "Meow"
    assert make_noise(snake) == "Eh?"
  end

  koan "errors are shaped differently than sucessful results" do
    result = case Map.fetch(%{}, :obviously_not_a_key) do
      {:ok, val} -> val
      :error -> "not present"
    end

    assert result == "not present"
  end
end
