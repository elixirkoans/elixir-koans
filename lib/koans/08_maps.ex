defmodule Maps do
  use Koans

  @intro "Maps"

  @person %{
    first_name: "Jon",
    last_name: "Snow",
    age: 27
  }

  koan "Maps represent structured data, like a person" do
    assert @person == %{first_name: "Jon", last_name: "Snow", age: 27}
  end

  koan "Fetching a value returns a tuple with ok when it exists" do
    assert Map.fetch(@person, :age) == {:ok, 27}
  end

  koan "Or the atom :error when it doesn't" do
    assert Map.fetch(@person, :family) == :error
  end

  koan "Extending a map is as simple as adding a new pair" do
    person_with_hobby = Map.put(@person, :hobby, "Kayaking")
    assert Map.fetch(person_with_hobby, :hobby) == {:ok, "Kayaking"}
  end

  koan "Put can also overwrite existing values" do
    older_person = Map.put(@person, :age, 37)
    assert Map.fetch(older_person, :age) == {:ok, 37}
  end

  koan "Or you can use some syntactic sugar for existing elements" do
    younger_person = %{@person | age: 16}
    assert Map.fetch(younger_person, :age) == {:ok, 16}
  end

  koan "Can remove pairs by key" do
    without_age = Map.delete(@person, :age)
    assert Map.has_key?(without_age, :age) == false
  end

  koan "Can merge maps" do
    assert Map.merge(%{first_name: "Jon"}, %{last_name: "Snow"}) == %{
             first_name: "Jon",
             last_name: "Snow"
           }
  end

  koan "When merging, the last map wins" do
    merged = Map.merge(@person, %{last_name: "Baratheon"})
    assert Map.fetch(merged, :last_name) == {:ok, "Baratheon"}
  end

  koan "You can also select sub-maps out of a larger map" do
    assert Map.take(@person, [:first_name, :last_name]) == %{first_name: "Jon", last_name: "Snow"}
  end
end
