defmodule Maps do
  use Koans

  koan "Maps represent structured data, like a person" do
    assert %{ :name => "Jon",
              :last_name => "Snow",
              :age => 27 } == %{ :name => :__,
                                 :last_name => "Snow",
                                 :age => 27 }
  end

  koan "You can get all the keys from the map" do
    assert Map.keys(%{ :name => "Jon", :last_name => "Snow", :age => 27 }) |> Enum.sort == :__
  end

  koan "Or you can also get all the values from it" do
    assert Map.values(%{ :name => "Jon", :last_name => "Snow", :age => 27 }) |> Enum.sort == :__
  end

  koan "Fetching a value returns a tuple with ok when it exists" do
    assert Map.fetch(%{ :name => "Jon", :last_name => "Snow", :age => 27 }, :age) == :__
  end

  koan "Or the atom :error when it doesnt" do
    assert Map.fetch(%{ :name => "Jon", :last_name => "Snow", :age => 27 }, :family) == :__
  end

  koan "Extending a map is a simple as putting in a new pair" do
    assert Map.put(%{ :name => "Jon", :last_name => "Snow"}, :age, 27) == :__
  end

  koan "Put can also overwrite existing values" do
    assert Map.put(%{ :name => "Jon", :last_name => "Snow", :age => 15}, :age, 27) == :__
  end

  koan "Or you can use some syntactic sugar for existing elements" do
    initial = %{ :name => "Jon", :last_name => "Snow", :age => 16}
    assert %{ initial | :age => 27 } == :__
  end

  koan "Can remove pairs by key" do
    assert Map.delete(%{ :name => "Jon", :last_name => "Snow", :age => 15}, :age) == :__
  end

  koan "If you have a list of pairs, you can turn them into a map" do
    assert Map.new( [{:name, "Jon"}, {:last_name, "Snow"}, {:age, 27}] ) == :__
  end

  koan "Going back to a list of pairs is just as easy" do
    assert Map.to_list(%{ :name => "Jon", :last_name => "Snow", :age => 27 }) == :__
  end

  koan "Can merge maps" do
    assert Map.merge(%{:name => "Jon"}, %{ :last_name => "Snow"}) == :__
  end

  koan "When merging, the last map wins" do
    assert Map.merge(%{:name => "Robert", :last_name => "Snow"}, %{ :last_name => "Baratheon"}) == :__
  end

  koan "You can also select sub-maps out of a larger map" do
    initial = %{ :name => "Jon", :last_name => "Snow", :age => 15}
    assert Map.take(initial, [:name, :last_name]) == :__
  end
end
