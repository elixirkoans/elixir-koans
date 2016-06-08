defmodule Numbers do
  require Integer
  use Koans

  @intro "Why is the number six so scared? Because seven eight nine!\nWe should get to know numbers a bit more!"

  koan "Are you odd?" do
    assert Integer.is_odd(3) == ___
  end

  koan "Actually you might be even" do
    assert Integer.is_even(4) == ___
  end

  koan "Let's grab the individual digits in a list" do
    individual_digits = Integer.digits(58127)
    assert individual_digits == ___
  end

  koan "Oh no! I need it back together" do
    number = Integer.undigits([1, 2, 3, 4])

    assert number == ___
  end

  koan "I think I need my number as a char" do
    char_digit = Integer.to_char_list(7)

    assert char_digit == ___
  end

  koan "Actually I want my number as a string" do
    string_digit = Integer.to_string(1234)

    assert string_digit == ___
  end

  koan "The meaning of life in hexidecimal is 2A!" do
    assert Integer.parse("2A", 16) == {___, ""}
  end

  koan "I don't want this decimal point, let's round up" do
    assert Float.ceil(34.25) == ___
  end

  koan "OK, I only want it to 1 decimal place" do
    assert Float.ceil(34.25, 1) == ___
  end

  koan "Rounding down is what I need" do
    assert Float.floor(99.99) == ___
  end

  koan "Rounding down to 2 decimal places" do
    assert Float.floor(12.345, 2) == ___
  end

  koan "Just want to parse to a float" do
    assert Float.parse("34.5") == {___, ""}
  end

  koan "Hmm, I want to parse this but it has some strings" do
    assert Float.parse("1 million dollars") == {___, " million dollars"}
  end

  koan "Round the number up or down for me" do
    assert Float.round(5.5) == ___
    assert Float.round(5.4) == ___
    assert Float.round(8.94, 1) == ___
    assert Float.round(-5.5674, 3) == ___
  end

  koan "I want the first and last in the range" do
    first..last = Range.new(1, 10)

    assert first == ___
    assert last == ___
  end

  koan "Does my number exist in the range?" do
    range = Range.new(1, 10)

    assert 4 in range == ___
    assert 10 in range == ___
    assert 0 in range == ___
  end

  koan "Is this a range?" do
    assert Range.range?(1..10) == ___
    assert Range.range?(0) == ___
  end
end
