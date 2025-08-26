defmodule Enums do
  @moduledoc false
  use Koans

  @intro "Enums"

  koan "Knowing how many elements are in a list is important for book-keeping" do
    assert Enum.count([1, 2, 3]) == ___
  end

  koan "Counting is similar to length" do
    assert length([1, 2, 3]) == ___
  end

  koan "But it allows you to count certain elements" do
    assert Enum.count([1, 2, 3], &(&1 == 2)) == ___
  end

  koan "Depending on the type, it counts pairs while length does not" do
    map = %{a: :foo, b: :bar}
    assert Enum.count(map) == ___
    assert_raise ___, fn -> length(map) end
  end

  def less_than_five?(n), do: n < 5

  koan "Elements can have a lot in common" do
    assert Enum.all?([1, 2, 3], &less_than_five?/1) == ___
    assert Enum.all?([4, 6, 8], &less_than_five?/1) == ___
  end

  def even?(n), do: rem(n, 2) == 0

  koan "Sometimes you just want to know if there are any elements fulfilling a condition" do
    assert Enum.any?([1, 2, 3], &even?/1) == ___
    assert Enum.any?([1, 3, 5], &even?/1) == ___
  end

  koan "Sometimes you just want to know if an element is part of the party" do
    input = [1, 2, 3]
    assert Enum.member?(input, 1) == ___
    assert Enum.member?(input, 30) == ___
  end

  def multiply_by_ten(n), do: 10 * n

  koan "Mapping converts each element of a list by running some function with it" do
    assert Enum.map([1, 2, 3], &multiply_by_ten/1) == ___
  end

  def odd?(n), do: rem(n, 2) == 1

  koan "Filter allows you to only keep what you really care about" do
    assert Enum.filter([1, 2, 3], &odd?/1) == ___
  end

  koan "Reject will help you throw out unwanted cruft" do
    assert Enum.reject([1, 2, 3], &odd?/1) == ___
  end

  koan "You three there, follow me!" do
    assert Enum.take([1, 2, 3, 4, 5], 3) == ___
  end

  koan "You can ask for a lot, but Enum won't hand you more than you give" do
    assert Enum.take([1, 2, 3, 4, 5], 10) == ___
  end

  koan "Just like taking, you can also drop elements" do
    assert Enum.drop([-1, 0, 1, 2, 3], 2) == ___
  end

  koan "Zip-up in pairs!" do
    letters = [:a, :b, :c]
    numbers = [1, 2, 3]
    assert Enum.zip(letters, numbers) == ___
  end

  koan "When you want to find that one pesky element, it returns the first" do
    assert Enum.find([1, 2, 3, 4], &even?/1) == ___
  end

  def divisible_by_five?(n), do: rem(n, 5) == 0

  koan "...but you don't quite find it..." do
    assert Enum.find([1, 2, 3], &divisible_by_five?/1) == ___
  end

  koan "...you can settle for a consolation prize" do
    assert Enum.find([1, 2, 3], :no_such_element, &divisible_by_five?/1) == ___
  end

  koan "Collapse an entire list of elements down to a single one by repeating a function." do
    assert Enum.reduce([1, 2, 3], 0, fn element, accumulator -> element + accumulator end) == ___
  end

  koan "Enum.chunk_every splits lists into smaller lists of fixed size" do
    assert Enum.chunk_every([1, 2, 3, 4, 5, 6], 2) == ___
    assert Enum.chunk_every([1, 2, 3, 4, 5], 3) == ___
  end

  koan "Enum.flat_map transforms and flattens in one step" do
    result =
      [1, 2, 3]
      |> Enum.flat_map(&[&1, &1 * 10])

    assert result == ___
  end

  koan "Enum.group_by organizes elements by a grouping function" do
    words = ["apple", "banana", "cherry", "apricot", "blueberry"]
    grouped = Enum.group_by(words, &String.first/1)

    assert grouped["a"] == ___
    assert grouped["b"] == ___
  end

  koan "Stream provides lazy enumeration for large datasets" do
    # Streams are lazy - they don't execute until you call Enum on them
    stream =
      1..1_000_000
      |> Stream.filter(&even?/1)
      |> Stream.map(&(&1 * 2))
      |> Stream.take(3)

    # Nothing has been computed yet!
    result = Enum.to_list(stream)
    assert result == ___
  end
end
