defmodule Maps do
  use Koans

  koan "Maps have keys and values" do
    assert %{ :the_key => "some value" } == %{ :the_key => "some value"}
  end

  koan "Has keys" do
    assert Map.keys(%{ :a => "A", :b => "B" }) == [:a, :b]
  end

  koan "Has values" do
    assert Map.values(%{ :a => "A", :b => "B" }) == ["A", "B"]
  end

  koan "Can read values based on a key" do
    assert Map.fetch(%{ :a => "A"}, :a) == {:ok, "A"}
    assert Map.fetch(%{ :a => "A"}, :z) == :error
    assert Map.fetch!(%{ :a => "A"}, :a) == "A"
  end

  koan "New pairs can be added" do
    assert Map.put(%{ :a => "A"}, :b, "B") == %{ :a => "A", :b => "B" }
  end

  koan "There is syntactic sugar to update existing keys" do
    initial = %{ :a => "A"}
    assert %{ initial | :a => "B" } == %{ :a => "B"}
  end

  koan "Put can also overwrite existing values" do
    assert Map.put(%{:a => "A"}, :a, "B") == %{ :a => "B"}
  end

  koan "Can remove pairs by key" do
    assert Map.delete(%{:a => "A", :b => "B"}, :b) == %{ :a => "A"}
  end

  koan "Can be created based on a list of pairs" do
    assert Map.new([{:a, "A"}, {:b, "B"}]) == %{ :a => "A", :b => "B" }
  end

  koan "Can be turned back into a list of pairs" do
    assert Map.to_list(%{ :a => "A", :b => "B" }) == [{:a, "A"}, {:b, "B"}]
  end

  koan "Can merge maps" do
    assert Map.merge(%{ :a => "A"}, %{:b => "B"}) == %{:a => "A", :b => "B"}
  end

  koan "When merging, the last map wins" do
    assert Map.merge(%{ :a => "A"}, %{:a => "X", :b => "B"}) == %{:a => "X", :b => "B"}
  end

  koan "Can extract smaller sub-maps" do
    the_map = %{ :a => "A", :b => "B", :c => "C" }
    assert Map.take(the_map, [:a, :b]) == %{ :a => "A", :b => "B"}
  end
end
