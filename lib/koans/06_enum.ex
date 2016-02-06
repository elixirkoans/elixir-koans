defmodule Enums do
  use Koans

  koan "can tell you how many elements there are" do
    assert Enum.count([1,2,3,4]) == 4
  end

  koan "enumerable can tell you if all elements have a certain property" do
    assert Enum.all?([1,2,3], fn element -> element < 5 end)

    refute Enum.all?([1, 2, 3], fn element -> element > 5 end)
  end

  koan "can tell you if there is _some_ element in the list for which a property holds" do
    assert Enum.any?([1,2,3], fn element -> rem(element, 2) == 0 end)

     Enum.any?([1,2,3], fn element -> rem(element, 5) == 0 end)
  end

  koan "can tell if an element is in the enumerable" do
    assert Enum.member?([1,2,3], 1)

    refute Enum.member?([1,2,3], 30)
  end

  koan "converts elements by calling a function for each element" do
    assert Enum.map([1,2,3], fn element -> element * 10 end) == [10,20,30]
    assert Enum.map([1,2,3], fn element -> rem(element, 2) == 0 end) == [false, true, false]
  end

  koan "only keeps elements that match a certain criteria" do
    assert Enum.filter([1,2,3], fn element -> rem(element, 2) == 1 end) == [1,3]
  end

  koan "removes elements that match a certain criteria" do
    assert Enum.reject([1,2,3], fn element -> rem(element, 2) == 1 end) == [2]
  end

  koan "can take a number of elements" do
    assert Enum.take([1,2,3,4,5], 3) == [1,2,3]
    assert Enum.take([1,2,3,4,5], 10) == [1,2,3,4,5]
  end

  koan "can take as long as a property holds" do
    assert Enum.take_while([1,2,3,4,5], fn element -> element < 4 end) == [1,2,3]
  end

  koan "can drop a number of elements" do
    assert Enum.drop([-1,0,1,2,3], 2) == [1,2,3]
  end

  koan "can drop as long as a property holds" do
    assert Enum.drop_while([-1,0,1,2,3], fn element -> element <= 0 end) == [1,2,3]
  end

  koan "can group elements by things they have in common" do
    assert Enum.group_by([1,2,3,4,5,6], fn element -> rem(element, 3) end) == %{ 0 => [6, 3], 1 => [4, 1], 2 => [5, 2]}

    odd_or_even = fn element -> if rem(element, 2) == 0 do :even else :odd end end

    assert Enum.group_by([1,2,3,4], odd_or_even) == %{ :odd => [3,1], :even => [4,2] }
  end

  koan "can merge two lists by picking pairs" do
    numbers = [1,2,3]
    letters = [:a, :b, :c]

    assert Enum.zip(numbers, letters) == [{1, :a}, {2, :b}, {3, :c}]

    more_numbers = numbers ++ [4,5]
    assert Enum.zip(more_numbers, letters) == [{1, :a}, {2, :b}, {3, :c}]
  end

  koan "can find elements by properties" do
    assert Enum.find([1,2,3], fn element -> rem(element,2) == 0 end) == 2
    assert Enum.find([1,2,3], fn element -> rem(element,5) == 0 end) == nil
    assert Enum.find([1,2,3], :no_such_element, fn element -> rem(element,5) == 0 end) == :no_such_element
  end

  koan "can reduce stuff" do
    assert Enum.reduce([1,2,3], 0, fn(element, accumulator) -> element + accumulator end) == 6

    assert Enum.reduce(["1", "2", "3"], "", fn(element, accumulator) -> element <> accumulator end) == "321"
  end
end
