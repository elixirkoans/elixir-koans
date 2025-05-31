defmodule Sigils do
  use Koans

  @intro "Sigils"

  koan "The ~s sigil is a different way of expressing string literals" do
    assert ~s{This is a string} == ___
  end

  koan "Sigils are useful to avoid escaping quotes in strings" do
    assert "\"Welcome to the jungle\", they said." == ___
  end

  koan "Sigils can use different delimiters" do
    matches? = ~s{This works!} == ~s[This works!]
    assert matches? == ___
  end

  koan "The lowercase ~s sigil supports string interpolation" do
    assert ~s[1 + 1 = #{1 + 1}] == ___
  end

  koan "The ~S sigil is similar to ~s but doesn't do interpolation" do
    assert ~S[1 + 1 = #{1+1}] == ___
  end

  koan "The ~w sigil creates word lists" do
    assert ~w(Hello world) == ___
  end

  koan "The ~w sigil also allows interpolation" do
    assert ~w(Hello 1#{1 + 1}3) == ___
  end

  koan "The ~W sigil behaves to ~w as ~S behaves to ~s" do
    assert ~W(Hello #{1+1}) == ___
  end
end
