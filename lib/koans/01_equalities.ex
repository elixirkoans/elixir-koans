defmodule Equalities do
  use Koans

  koan "We shall contemplate truth by testing reality, via equality" do
    assert true == true
  end

  koan "To understand reality, we must compare our expectations against reality" do
    assert 2 == 1 + 1
  end

  koan "Some things may appear different, but be the same" do
    assert 1 == 2 / 2
  end

  koan "Something is not equal to nothing" do
    assert !(1 == nil)
  end

  koan "When things cannot be equal, they must be different" do
    refute :something == 4
  end
end
