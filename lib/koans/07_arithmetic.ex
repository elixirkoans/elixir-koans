defmodule Arithmetic do
  use Koans

  koan "it can add numbers" do
    assert 3 + 4 == 7
  end

  koan "it can substract numbers" do
    assert 7 - 4 == 3
  end

  koan "it can multiply" do
    assert 3 * 4 == 12
  end

  koan "floats and integers can be equal..." do
    assert 3.0 == 3
  end

  koan "..unless they are not precisely the same" do
    assert 3.2 != 3
  end

  koan "it does floating point division" do
    assert 5 / 2 == 2.5
  end

  koan "it does integer division" do
    numerator = 5
    denominator = 2
    assert div(numerator, denominator) == 2
  end

  koan "it calculates the remainder of a division" do
    numerator = 5
    denominator = 2
    assert rem(numerator, denominator) == 1
  end

  koan "it finds the maximum in a list" do
    assert Enum.max([1,2,3,4]) == 4
  end

  koan "it can compare numbers" do
    assert 5 > 2
    assert 5 >= 5
    assert 3 < 7
    assert 5 <= 5
  end

  koan "it finds the minimum in a list" do
    assert Enum.min([1,2,3,4]) == 1
  end

  koan "it can not divide by zero" do
    try do
      1 / 0.0
    rescue
       ArithmeticError -> true
    end
  end
end
