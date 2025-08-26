defmodule Functions do
  @moduledoc false
  use Koans

  @intro "Functions"

  def greet(name) do
    "Hello, #{name}!"
  end

  koan "Functions map arguments to outputs" do
    assert greet("World") == ___
  end

  def multiply(a, b), do: a * b

  koan "Single line functions are cool, but mind the comma and the colon!" do
    assert 6 == multiply(2, ___)
  end

  def first(foo, bar), do: "#{foo} and #{bar}"
  def first(foo), do: "Only #{foo}"

  koan "Functions with the same name are distinguished by the number of arguments they take" do
    assert first("One", "Two") == ___
    assert first("One") == ___
  end

  def repeat_again(message, times \\ 3) do
    String.duplicate(message, times)
  end

  koan "Functions can have default argument values" do
    assert repeat_again("Hello ") == ___
    assert repeat_again("Hello ", 2) == ___
  end

  def sum_up(thing) when is_list(thing), do: :entire_list
  def sum_up(_thing), do: :single_thing

  koan "Functions can have guard expressions" do
    assert sum_up([1, 2, 3]) == ___
    assert sum_up(1) == ___
  end

  def bigger(a, b) when a > b, do: "#{a} is bigger than #{b}"
  def bigger(a, b) when a <= b, do: "#{a} is not bigger than #{b}"

  koan "Intricate guards are possible, but be mindful of the reader" do
    assert bigger(10, 5) == ___
    assert bigger(4, 27) == ___
  end

  def get_number(0), do: "The number was zero"
  def get_number(number), do: "The number was #{number}"

  koan "For simpler cases, pattern matching is effective" do
    assert get_number(0) == ___
    assert get_number(5) == ___
  end

  koan "Little anonymous functions are common, and called with a dot" do
    multiply = fn a, b -> a * b end
    assert multiply.(2, 3) == ___
  end

  koan "You can even go shorter, by using capture syntax `&()` and positional arguments" do
    multiply = &(&1 * &2)
    assert multiply.(2, 3) == ___
  end

  koan "Prefix a string with & to build a simple anonymous greet function" do
    greet = &"Hi, #{&1}!"
    assert greet.("Foo") == ___
  end

  koan "You can build anonymous functions out of any elixir expression by prefixing it with &" do
    three_times = &[&1, &1, &1]
    assert three_times.("foo") == ___
  end

  koan "You can use pattern matching to define multiple cases for anonymous functions" do
    inspirational_quote = fn
      {:ok, result} -> "Success is #{result}"
      {:error, reason} -> "You just lost #{reason}"
    end

    assert inspirational_quote.({:ok, "no accident"}) == ___
    assert inspirational_quote.({:error, "the game"}) == ___
  end

  def times_five_and_then(number, fun), do: fun.(number * 5)
  def square(number), do: number * number

  koan "You can pass functions around as arguments. Place an '&' before the name and state the arity" do
    assert times_five_and_then(2, &square/1) == ___
  end

  koan "The '&' operation is not needed for anonymous functions" do
    cube = fn number -> number * number * number end
    assert times_five_and_then(2, cube) == ___
  end

  koan "The result of a function can be piped into another function as its first argument" do
    result =
      "full-name"
      |> String.split("-")
      |> Enum.map_join(" ", &String.capitalize/1)

    assert result == ___
  end

  koan "Pipes make data transformation pipelines readable" do
    numbers = [1, 2, 3, 4, 5]

    result =
      numbers
      |> Enum.filter(&(&1 > 2))
      |> Enum.map(&(&1 * 2))
      |> Enum.sum()

    assert result == ___

    user_input = "  Hello World  "

    cleaned =
      user_input
      |> String.trim()
      |> String.downcase()
      |> String.replace(" ", "_")

    assert cleaned == ___
  end

  koan "Conveniently keyword lists can be used for function options" do
    transform = fn str, opts ->
      if opts[:upcase] do
        String.upcase(str)
      else
        str
      end
    end

    assert transform.("good", upcase: true) == ___
    assert transform.("good", upcase: false) == ___
  end

  koan "Anonymous functions can use the & capture syntax for very concise definitions" do
    add_one = &(&1 + 1)
    multiply_by_two = &(&1 * 2)

    result = 5 |> add_one.() |> multiply_by_two.()
    assert result == ___

    # You can also capture existing functions
    string_length = &String.length/1
    assert string_length.("hello") == ___
  end
end
