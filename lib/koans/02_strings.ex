defmodule Strings do
  use Koans

  koan "Strings are there to represent text" do
    assert "hello" == ___
  end

  koan "They can be put together" do
    assert "hello world" == ___ <> "world"
  end

  koan "Or pulled apart when needed" do
    assert ___ == String.split("hello world")
  end

  koan "Be careful, a message may be altered" do
    assert ___ == String.replace("An awful day", "awful", "incredible")
  end

  koan "But strings never lie about themselves" do
    assert true == String.contains?("An incredible day", ___)
  end

  koan "Sometimes you want just the opposite of what is given" do
    assert ___ == String.reverse("ananab")
  end

  koan "Other times a little cleaning is in order" do
    assert ___ == String.strip("  \n banana\n  ")
  end

  koan "Repetition is the mother of learning" do
    assert "StringStringString" == String.duplicate(___, 3)
  end

  koan "Strings can be louder when necessary" do
    assert "LISTEN" == String.upcase(___)
  end
end
