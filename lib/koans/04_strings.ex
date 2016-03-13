defmodule Strings do
  use Koans

  koan "Strings are there to represent text" do
    assert "hello" == :__
  end

  koan "They can be put together" do
    assert "hello world" == :__ <> "world"
  end

  koan "Or pulled apart when needed" do
    assert :__ == String.split("hello world")
  end

  koan "Be careful, a message may be altered" do
    assert :__ == String.replace("An incredible day", "incredible", "awful")
  end

  koan "But strings never lie about themselves" do
    assert true == String.contains?("An incredible day", :__)
  end

  koan "Sometimes you want just the opposite of what is given" do
    assert :__ == String.reverse("ananab")
  end

  koan "Other times a little cleaning is in order" do
    assert :__ == String.strip("  \n banana\n  ")
  end

  koan "Repetition is the mother of learning" do
    assert "StringStringString" == String.duplicate(:__, 3)
  end

  koan "Strings can be louder when necessary" do
    assert "LISTEN" == String.upcase(:__)
  end
end
