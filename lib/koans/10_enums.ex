defmodule Enums do
  use Koans

  koan "Knowing how many elements are in a list is important for book-keeping" do
    assert Enum.count([1,2,3]) == :__
  end

  koan "The same applies for counting elements in a map" do
    assert Enum.count(%{ :a => :foo, :b => :bar}) == :__
  end

  koan "Or a keyword list" do
    assert Enum.count([a: 77, b: 23, c: 12, d: 33, e: 90, f: 113]) == :__
  end

  def less_than_five?(n), do: n < 5
  koan "Elements can have a lot in common" do
    assert Enum.all?([1,2,3], &less_than_five?/1) == :__
  end

  def less_than_two?(n), do: n < 2
  koan "If one if different, all elements are not alike" do
    assert Enum.all?([1, 2, 3, 2], &less_than_two?/1) == :__
  end

  def even?(n), do: rem(n, 2) == 0

  koan "sometimes you you just want to know if there are any elements fullfilling a condition" do
    assert Enum.any?([1,2,3], &even?/1) == :__
  end

  def  divisible_by_five?(n), do: rem(n, 5) == 0

  koan "if not a single element fits the bill, any? returns false" do
    assert Enum.any?([1,2,3], &divisible_by_five?/1) == :__
  end

  koan "Sometimes you just want to know if an element is part of the party" do
    assert Enum.member?([1,2,3], 1) == :__
  end

  koan "And sometimes your invited guests don't show up and miss the party" do
    assert Enum.member?([1,2,3], 30) == :__
  end

  def multiply_by_ten(n), do: 10 * n

  koan "map converts each element of a list by running some function with it" do
    assert Enum.map([1,2,3], &multiply_by_ten/1) == :__
  end

  koan "You can even return a list with entirely different types" do
    assert Enum.map([1,2,3], &even?/1) == :__
  end

  koan "But keep in mind that the original list remains unchanged" do
    input = [1,2,3,4]
    assert Enum.map(input, &even?/1) == :__
    assert input == :__
  end

  def odd?(n), do: rem(n, 2) == 1

  koan "Filter allows you to only keep what you really care about" do
    assert Enum.filter([1,2,3], &odd?/1) == :__
  end

  koan "Reject will help you throw out unwanted cruft" do
    assert Enum.reject([1,2,3], &odd?/1) == :__
  end

  koan "You three there, follow me!" do
    assert Enum.take([1,2,3,4,5], 3) == :__
  end

  koan "You can ask for a lot, but Enum won't hand you more than you give" do
    assert Enum.take([1,2,3,4,5], 10) == :__
  end

  koan "Take what you can..." do
    assert Enum.take_while([1,2,3,4,5,6,7], &less_than_five?/1) == :__
  end

  koan "Just like taking, you can also drop elements" do
    assert Enum.drop([-1,0,1,2,3], 2) == :__
  end

  def negative?(n), do: n < 0
  koan "Drop elements until you are happy" do
    assert Enum.drop_while([-1,0,1,2,3], &negative?/1) == :__
  end

  koan "Forming groups makes uns stronger" do
    odd_or_even = fn element -> if rem(element, 2) == 0 do :even else :odd end end

    assert Enum.group_by([1,2,3,4], odd_or_even) == :__
  end

  koan "You get as many groups as you can have different results" do
    assert Enum.group_by([1,2,3,4,5,6], fn element -> rem(element, 3) end) == :__
  end

  koan "Zip-up in pairs!" do
    numbers = [1,2,3]
    letters = [:a, :b, :c]
    assert Enum.zip(numbers, letters) == :__
  end

 koan "Sorry, but if you don't have a pair you are left out" do
    more_numbers = [1,2,3] ++ [4,5]
    letters = [:a, :b, :c]
    assert Enum.zip(more_numbers, letters) == :__
  end

  koan "When you want to find that one pesky element" do
    assert Enum.find([1,2,3], &even?/1) == :__
  end

  koan "...but you don't quite find it..." do
    assert Enum.find([1,2,3], &divisible_by_five?/1) == :__
  end

  koan "...you can settle for a consolation prize" do
    assert Enum.find([1,2,3], :no_such_element, &divisible_by_five?/1) == :__
  end

  koan "Collapse an entire list of elements down to a single one by repeating a function." do
    assert Enum.reduce([1,2,3], 0, fn(element, accumulator) -> element + accumulator end) == :__
  end
end
