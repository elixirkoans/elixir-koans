defmodule Equalities do
  use Koans

  koan "We shall contemplate truth by testing reality, via equality" do
    assert true == ___
  end

  koan "Not something is the opposite of it" do
    assert !true == ___
  end

  koan "To understand reality, we must compare our expectations against reality" do
    assert 2 == 1 + ___
  end

  koan "Some things may appear different, but be the same" do
    assert 1 == 2 / ___
  end

  koan "Unless they actually are different" do
    assert 3.2 != ___
  end

  koan "Some may be looking for bigger things" do
    assert ___ > 3
  end

  koan "Others are happy with less" do
    assert ___ < 3
  end
end
