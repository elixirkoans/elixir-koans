defmodule Tuples do
  use Koans

  @intro "Tuples"

  koan "Tuples can contain different things" do
    assert {:a, 1, "hi"} == {:a, 1, "hi"}
  end

  koan "Tuples have a size" do
    assert tuple_size({:a, :b, :c}) == 3
  end

  koan "You can pull out individual elements" do
    assert elem({:a, "hi"}, 1) == "hi"
  end

  koan "You can change individual elements of a tuple" do
    assert put_elem({:a, "hi"}, 1, "bye") == {:a, "bye"}
  end

  koan "You can also simply extend a tuple with new stuff" do
    assert Tuple.insert_at({:a, "hi"}, 1, :new_thing) == {:a, :new_thing, "hi"}
  end

  koan "Add things at the end" do
    assert Tuple.append({"Huey", "Dewey"}, "Louie") == {"Huey", "Dewey", "Louie"}
  end

  koan "Or remove them" do
    assert Tuple.delete_at({:this, :is, :not, :awesome}, 2) == {:this, :is, :awesome}
  end

  koan "Turn it into a list in case you need it" do
    assert Tuple.to_list({:this, :can, :be, :a, :list}) == [:this, :can, :be, :a, :list]
  end
end
