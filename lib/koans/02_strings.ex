defmodule Strings do
  use Koans

  @intro "Strings"

  koan "Strings are there to represent text" do
    assert "hello" == "hello"
  end

  koan "Values may be inserted into strings by interpolation" do
    assert "1 + 1 = #{1 + 1}" == "1 + 1 = 2"
  end

  koan "They can be put together" do
    assert "hello world" == "hello " <> "world"
  end

  koan "Or pulled apart into a list when needed" do
    assert ["hello", "world"] == String.split("hello world", " ")
  end

  koan "Be careful, a message may be altered" do
    assert String.replace("An awful day", "awful", "incredible") == "An incredible day"
  end

  koan "But strings never lie about themselves" do
    assert true == String.contains?("An incredible day", "incredible")
  end

  koan "Sometimes you want just the opposite of what is given" do
    assert "banana" == String.reverse("ananab")
  end

  koan "Other times a little cleaning is in order" do
    assert String.trim("  \n banana\n  ") == "banana"
  end

  koan "Repetition is the mother of learning" do
    assert String.duplicate("String", 3) == "StringStringString"
  end

  koan "Strings can be louder when necessary" do
    assert String.upcase("listen") == "LISTEN"
  end
end
