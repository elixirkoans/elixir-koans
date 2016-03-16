defmodule PatternMatching do
  use Koans

  koan "one matches one" do
    assert match?(1, :__)
  end

  koan "a pattern can change" do
    a = 1
    assert a = :__
  end

  # TODO not sure about this koan?
  koan "a pattern can also be strict" do
    a = 1
    assert ^a = :__
  end

  koan "patterns can be used to pull things apart" do
    [head | _tail] = [1,2,3,4]

    assert head == :__
  end

  koan "...whichever side you actually need" do
    [_head | tail] = [1,2,3,4]

    assert tail == :__
  end


  koan "and then put them back together" do
    head = 1
    tail = [2,3,4]

    assert :__ == [head | tail]
  end

  koan "Some values can be irrelevant" do
    [_first, _second, third, _fourth] = [1,2,3,4]

    assert third == :__
  end

  koan "strings come apart just a easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == :__
  end

  koan "patterns show what you really care about" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == :__
  end

  koan "the pattern can make assertions about what it expects" do
    assert match?([1, _, _], :__)
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "functions can declare what kind of arguments they accept" do
    dog = %{type: "dog", legs: 4, age: 9, color: "brown"}

    assert make_noise(dog) == :__
  end

  koan "...and for cats..." do
    cat = %{type: "cat", legs: 4, age: 3, color: "grey"}
    assert make_noise(cat) == :__
  end

  koan "...and for snakes..." do
    snake = %{type: "snake", legs: 0, age: 20, color: "black"}
    assert make_noise(snake) == :__
  end

  koan "errors are shaped differently than sucessful results" do
    result = case Map.fetch(%{}, :obviously_not_a_key) do
      :error -> "not present"
      _ -> flunk("I should not happen")
    end

    assert result == :__
  end
end
