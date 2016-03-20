defmodule Arithmetic do
  use Koans

  koan "it can add numbers" do
    assert 3 + :__ == 7
  end

  koan "it can substract numbers" do
    assert 7 - 4 == :__
  end

  koan "it can multiply" do
    assert 3 * 4 == :__
  end

  koan "floats and integers can be equal..." do
    assert 3.0 == :__
  end

  koan "..unless they are not precisely the same" do
    assert 3.2 != :__
  end

  koan "it does floating point division" do
    assert 5 / 2 == :__
  end

  koan "it does integer division" do
    numerator = 5
    denominator = 2
    assert div(numerator, denominator) == :__
  end

  koan "it calculates the remainder of a division" do
    numerator = 5
    denominator = 2
    assert rem(numerator, denominator) == :__
  end

  koan "it finds the maximum in a list" do
    assert Enum.max([1,2,3,4]) == :__
  end

  koan "it finds the minimum in a list" do
    assert Enum.min([1,2,3,4]) == :__
  end

  koan "it can compare numbers" do
    assert 5 > :__
  end

end
