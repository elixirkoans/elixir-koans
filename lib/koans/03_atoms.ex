defmodule Atoms do
  use Koans

  koan "Atoms are sort of like strings" do
    adam = :human
    assert adam == ___
  end

  koan "Strings can be converted to atoms, and vice versa" do
    assert String.to_atom("atomized") == ___
    assert Atom.to_string(:stringified) == ___
  end

  koan "It is surprising to find out that booleans are atoms" do
    assert is_atom(true) == ___
    assert is_atom(false) == ___
    assert :true == ___
    assert :false == ___
  end

  koan "Modules are also atoms" do
    assert is_atom(String) == ___
    assert :"Elixir.String" == ___
    assert :"Elixir.String".upcase("hello") == ___
  end

  koan "Atoms are used to access Erlang" do
    assert :erlang.is_list([]) == ___
    assert :lists.sort([2, 3, 1]) == ___
  end
end
