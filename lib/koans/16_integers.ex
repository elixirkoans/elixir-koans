defmodule Integers do
  require Integer
  use Koans

  @intro "Integers"

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
end