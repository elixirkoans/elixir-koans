defmodule Functions do
  use Koans

  def greet(name) do
    "Hello, #{name}!"
  end

  koan "Functions take arguments and return values" do
    assert greet("World") == :__
  end

  def quick_inline_product(a, b), do: a * b

  koan "Short functions can be defined in a single line, but mind the comman and colon" do
    assert quick_inline_product(2,:__) == 6
  end

  def will_change(choice) do
    if choice do
      :it_was_truthy
    else
      "It really wasn't"
    end
  end

  koan "Functions can return different things" do
    assert will_change(true) == :__
    assert will_change(false) == :__
  end

  def repeat(times, message) do
    String.duplicate(message, times)
  end

  koan "Functions can have more than one arguement" do
    assert repeat(3, "Hello ") == :__
  end

  def repeat_again(times \\ 5, message) do
    String.duplicate(message, times)
  end

  koan "But sometimes, you may want to default some arguments" do
    assert repeat_again("Hello ") == :__
  end

  def first(foo, bar), do: "#{foo} and #{bar}"
  def first(foo), do: "only #{foo}"

  koan "Functions with the same name are distinguished by the number of arguments they take" do
    assert first("One", "Two") == :__
    assert first("One") == :__
  end

  def sum_up(thing) when is_list(thing), do: :entire_list
  def sum_up(_thing), do: :single_thing

  koan "You can 'guard' functions from their arguments" do
    assert sum_up([1,2,3]) == :__
    assert sum_up(1) == :__
  end

  def bigger(a,b) when a >  b, do: "#{a} is bigger than #{b}"
  def bigger(a,b) when a <= b, do: "#{a} is not bigger than #{b}"

  koan "You can also create intricate guards based on the values." do
    assert bigger(10, 5) == :__
    assert bigger(4, 27) == :__
  end

  def the_length(0), do: "It was zero"
  def the_length(number), do: "The length was #{number}"

  koan "You can also 'guard' with concrete values" do
    assert the_length(0) == :__
  end

  koan "Or just let the argument roll" do
    assert the_length(5) == :__
  end

  koan "You can also define inline functions and call them with .()" do
    multiply = fn (a,b) -> a * b end
    assert multiply.(2,3) == :__
  end

  koan "You can even go shorter, by using &(..) and positional arguments" do
    multiply = &(&1 * &2)
    assert multiply.(2,3) == :__
  end

  def two_arguments(_first, second), do: second
  koan "You can also show that certain arguments are ignored in the body by adding an underscore" do
    assert two_arguments(:hi_there, "the other one") == :__
  end

  def multiply_then_call(number, fun), do: fun.(number*5)
  def square(number), do: number * number

  koan "You can 'capture' functions if you want to pass them around as values. Mind the ampersand '&' and the slash followed by the number of args." do
    assert multiply_then_call(2, &square/1) == :__
  end

  koan "Functions can be combined elegantly with the pipe operator" do
    result = "full-name"
    |> String.split("-")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(" ")

    assert result == :__
  end
end
