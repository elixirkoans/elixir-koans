defmodule Functions do
  use Koans

  def inside() do
    :light
  end
  # A function starts with 'def', has a 'do-end' pair
  koan "it returns the last statement that was called" do
    assert inside() == :light
  end

  def quick_inline_product(a, b), do: a * b
  koan "Short functions can be defined in a single line, but mind the comman and colon!" do
    assert quick_inline_product(2,3) == 6
  end

  # A function can have an argument between parentheses, after the name
  def will_change(choice) do
    if choice do
      :it_was_truthy
    else
      "It really wasn't"
    end
  end

  koan "Can return different things" do
    assert will_change(true) == :it_was_truthy
    assert will_change(false) == "It really wasn't"
  end

  def repeat(times, message) do
    String.duplicate(message, times)
  end

  koan "Functions can have more than one arguement" do
    assert repeat(3, "Hello ") == "Hello Hello Hello "
  end

  def repeat_again(times \\ 3, message) do
    String.duplicate(message, times)
  end

  koan "But sometimes, you may want to default some arguments" do
    assert repeat_again("Hello ") == "Hello Hello Hello "
  end

  def first(foo, bar), do: "#{foo} and #{bar}"
  def first(foo), do: "only #{foo}"
  koan "Functions are distinguished by name and arity - the number of arguments" do
    assert first("One", "Two") == "One and Two"
    assert first("One") == "only One"
  end

  def sum_up(thing) when is_list(thing), do: :entire_list
  def sum_up(_thing), do: :single_thing
  koan "You can 'guard' functions against their arguments" do
    assert sum_up([1,2,3]) == :entire_list
    assert sum_up(1) == :single_thing
  end

  def bigger(a,b) when a >  b, do: "#{a} is bigger than #{b}"
  def bigger(a,b) when a <= b, do: "#{a} is not bigger than #{b}"
  koan "You can also create intricate guards based on the values" do
    assert bigger(10, 5) == "10 is bigger than 5"
    assert bigger(4, 27) == "4 is not bigger than 27"
  end

  def the_length(0), do: "It was zero"
  def the_length(number), do: "The length was #{number}"
  koan "You can also 'guard' with concrete values" do
    assert the_length(0) == "It was zero"
    assert the_length(5) == "The length was 5"
  end

  koan "You can also define inline functions and call them with .()" do
    multiply = fn (a,b) -> a * b end
    assert multiply.(2,3) == 6
  end

  koan "You can even go shorter, by using &(..) and positional arguments" do
    multiply = &(&1 * &2)
    assert multiply.(2,3) == 6
  end

  def two_arguments(_first, second), do: second
  koan "You can also show that certain arguments are ignored in the body by adding an underscore" do
    assert two_arguments(:hi_there, "the other one") == "the other one"
  end

  def multiply_then_call(number, fun), do: fun.(number*5)
  def square(number), do: number * number
  koan "You can 'capture' functions if you want to pass them around as values" do
    assert multiply_then_call(2, &square/1) == 100
  end
end
