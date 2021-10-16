defmodule Enums do
  use Koans

  @intro "Enums"

  koan "Knowing how many elements are in a list is important for book-keeping" do
    assert Enum.count([1, 2, 3]) == 3
  end

  koan "Depending on the type, it counts pairs" do
    assert Enum.count(%{a: :foo, b: :bar}) == 2
  end

  def less_than_five?(n), do: n < 5

  koan "Elements can have a lot in common" do
    assert Enum.all?([1, 2, 3], &less_than_five?/1) == true
    assert Enum.all?([4, 6, 8], &less_than_five?/1) == false
  end

  def even?(n), do: rem(n, 2) == 0

  koan "Sometimes you just want to know if there are any elements fulfilling a condition" do
    assert Enum.any?([1, 2, 3], &even?/1) == true
    assert Enum.any?([1, 3, 5], &even?/1) == false
  end

  koan "Sometimes you just want to know if an element is part of the party" do
    input = [1, 2, 3]
    assert Enum.member?(input, 1) == true
    assert Enum.member?(input, 30) == false
  end

  def multiply_by_ten(n), do: 10 * n

  koan "Map converts each element of a list by running some function with it" do
    assert Enum.map([1, 2, 3], &multiply_by_ten/1) == [10, 20, 30]
  end

  def odd?(n), do: rem(n, 2) == 1

  koan "Filter allows you to only keep what you really care about" do
    assert Enum.filter([1, 2, 3], &odd?/1) == [1, 3]
  end

  koan "Reject will help you throw out unwanted cruft" do
    assert Enum.reject([1, 2, 3], &odd?/1) == [2]
  end

  koan "You three there, follow me!" do
    assert Enum.take([1, 2, 3, 4, 5], 3) == [1, 2, 3]
  end

  koan "You can ask for a lot, but Enum won't hand you more than you give" do
    assert Enum.take([1, 2, 3, 4, 5], 10) == [1, 2, 3, 4, 5]
  end

  koan "Just like taking, you can also drop elements" do
    assert Enum.drop([-1, 0, 1, 2, 3], 2) == [1, 2, 3]
  end

  koan "Zip-up in pairs!" do
    letters = [:a, :b, :c]
    numbers = [1, 2, 3]
    assert Enum.zip(letters, numbers) == [a: 1, b: 2, c: 3]
  end

  koan "When you want to find that one pesky element" do
    assert Enum.find([1, 2, 3, 4], &even?/1) == 2
  end

  def divisible_by_five?(n), do: rem(n, 5) == 0

  koan "...but you don't quite find it..." do
    assert Enum.find([1, 2, 3], &divisible_by_five?/1) == nil
  end

  koan "...you can settle for a consolation prize" do
    assert Enum.find([1, 2, 3], :no_such_element, &divisible_by_five?/1) == :no_such_element
  end

  koan "Collapse an entire list of elements down to a single one by repeating a function." do
    assert Enum.reduce([1, 2, 3], 0, fn element, accumulator -> element + accumulator end) == 6
  end
end
