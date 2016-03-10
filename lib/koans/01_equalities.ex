defmodule Equalities do
  use Koans

  koan "We shall contemplate truth by testing reality, via equality" do
    assert true == :__
  end

  koan "To understand reality, we must compare our expectations against reality" do
    assert 2 == 1 + :__
  end

  koan "Some things may appear different, but be the same" do
    assert 1 == 2 / :__
  end

  koan "Something is not equal to nothing" do
    assert !(:__ == nil)
  end

  koan "When things cannot be equal, they must be different" do
    refute :__ == 4
  end
end
