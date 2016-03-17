defmodule Tuples do
  use Koans

  koan "tuples have a size" do
    assert tuple_size({:a, :b, :c}) == :__
  end

  koan "tuples can contain different things" do
    assert {:a, 1, "hi"} == :__
  end

  koan "you can pull out individual elements" do
    assert elem({:a, "hi"}, 1) == :__
  end

  koan "you can change individual elements of a tuple" do
    assert put_elem({:a, "hi"}, 1, "bye") == :__
  end

  koan "you can also simply extend a tuple with new stuff" do
    assert Tuple.insert_at({:a, "hi"}, 1, :new_thing) == :__
  end

  koan "...avoid falling of the edge" do
    assert_raise :__, fn ->  Tuple.insert_at({:a, "hi"}, 12, :new_thing) end
  end

  koan "add things at the end" do
    assert Tuple.append({"Huey", "Dewey"}, "Louie") == :__
  end

  koan "or also remove them" do
    assert Tuple.delete_at({:this, :is, :not, :awesome}, 2) == :__
  end

  koan "you can't delete what you don't have" do
    assert_raise :__, fn ->  Tuple.delete_at({:a, "hi"}, 12) end
  end

  koan "turn it into a list in case you need it" do
    assert Tuple.to_list({:this, :can, :be, :a, :list}) == :__
  end
end
