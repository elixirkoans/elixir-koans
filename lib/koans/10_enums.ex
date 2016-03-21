defmodule Enums do
  use Koans

  koan "Knowing how many elements are in a list is important for book-keeping" do
    assert Enum.count([1,2,3]) == :__
  end

  koan "...the same applies for counting elements in a map..." do
    assert Enum.count(%{ :a => :foo, :b => :bar}) == :__
  end

  koan "..or a keyword list..." do
    assert Enum.count([a: 77, b: 23, c: 12, d: 33, e: 90, f: 113]) == :__
  end

  koan "Elements can have a lot in common" do
    less_than_five = &(&1 <=5)
    assert Enum.all?([1,2,3], less_than_five) == :__
  end

  koan "If one if different, all elements are not alike" do
    less_than_two = &(&1 <=2)
    assert Enum.all?([1, 2, 3, 2], less_than_two) == :__
  end

  koan "sometimes you you just want to know if there are any elements fullfilling a condition" do
    is_even? = &(rem(&1, 2) == 0)
    assert Enum.any?([1,2,3], is_even?) == :__
  end

  koan "if not a single element fits the bill, any? returns false" do
    divisible_by_five = &(rem(&1, 5) == 0)
    assert Enum.any?([1,2,3], divisible_by_five) == :__
  end

  koan "Sometimes you just want to know if an element is part of the party" do
    assert Enum.member?([1,2,3], 1) == :__
  end

  koan "And sometimes your invited guests don't show up and miss the party" do
    assert Enum.member?([1,2,3], 30) == :__
  end

  koan "map converts each element of a list by running some function with it" do
    multiply_by_ten = &(&1 * 10)
    assert Enum.map([1,2,3], multiply_by_ten) == :__
  end

  koan "You can even return a list with entirely different types" do
    is_even? = &(rem(&1,2) == 0)
    assert Enum.map([1,2,3], is_even?) == :__
  end

  koan "But keep in mind that the original list remains unchanged" do
    input = [1,2,3,4]
    assert Enum.map(input, fn element -> rem(element, 2) == 0 end) == :__
    assert input == :__
  end

  koan "Filter allows you to only keep what you really care about" do
    is_odd? = &(rem(&1, 2) == 1)
    assert Enum.filter([1,2,3], is_odd?) == :__
  end

  koan "Reject will help you throw out unwanted cruft" do
    is_odd? = &(rem(&1, 2) == 1)
    assert Enum.reject([1,2,3], is_odd?) == :__
  end

  koan "You three there, follow me!" do
    assert Enum.take([1,2,3,4,5], 3) == :__
  end

  koan "You can ask for a lot, but Enum won't hand you more than you give" do
    assert Enum.take([1,2,3,4,5], 10) == :__
  end

  koan "Take what you can..." do
    less_than_four = &(&1 < 4)
    assert Enum.take_while([1,2,3,4,5,6,7], less_than_four) == :__
  end

  koan "Just like taking, you can also drop elements" do
    assert Enum.drop([-1,0,1,2,3], 2) == :__
  end

  koan "Drop elements until you are happy" do
    negative = &(&1 <= 0)
    assert Enum.drop_while([-1,0,1,2,3], negative) == :__
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
    assert Enum.find([1,2,3], fn element -> rem(element,2) == 0 end) == :__
  end

  koan "...but you don't quite find it..." do
    assert Enum.find([1,2,3], fn element -> rem(element,5) == 0 end) == :__
  end

  koan "...you can settle for a consolation prize" do
    assert Enum.find([1,2,3], :no_such_element, fn element -> rem(element,5) == 0 end) == :__
  end

  koan "Collapse an entire list of elements down to a single one by repeating a function." do
    assert Enum.reduce([1,2,3], 0, fn(element, accumulator) -> element + accumulator end) == :__
  end
end
