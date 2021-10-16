defmodule Atoms do
  use Koans

  @intro "Atoms"

  koan "Atoms are constants where their name is their own value" do
    adam = :human
    assert adam == :human
  end

  koan "It is surprising to find out that booleans are atoms" do
    assert is_atom(true) == true
    assert is_boolean(false) == true
    assert true == true
    assert false == false
  end

  koan "Like booleans, the nil value is also an atom" do
    assert is_atom(nil) == true
    assert nil == nil
  end
end
