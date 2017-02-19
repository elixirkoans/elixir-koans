defmodule Equalities do
  use Koans

  @intro  """
  Welcome to the Elixir koans.
  Let these be your first humble steps towards learning a new language.

  The path laid in front of you is one of many.
  """

  # Replace ___ with the answer to make the koan pass.
  koan "We shall contemplate truth by testing reality, via equality" do
    assert true == true
  end

  koan "Not something is the opposite of it" do
    assert !true == false
  end

  koan "To understand reality, we must compare our expectations against reality" do
    assert 2 == 1 + 1
  end

  koan "Some things may appear different, but be the same" do
    assert 1 == 2 / 2
  end

  koan "Unless they actually are different" do
    assert 3.2 != 3
  end

  koan "Some may be looking for bigger things" do
    assert 4 > 3
  end

  koan "Others are happy with less" do
    assert 2 < 3
  end
end
