defmodule Structs do
  use Koans

  defmodule Person do
    defstruct [:name, :age ]
  end

  koan "you can access the fields of a struct" do
    nobody = %Person{}
    assert nobody.age == :__
  end

  koan "You can pass initial values to structs" do
    joe = %Person{name: "Joe", age: 23}
    assert joe.name == :__
  end

  koan "update fields with the pipe '|' operator" do
    joe = %Person{name: "Joe", age: 23}
    older = %{ joe | age: joe.age + 10}
    assert  older.age == :__
  end

  koan "the original struct is not affected by updates" do
    joe = %Person{name: "Joe", age: 23}
    assert %{ joe | age: joe.age + 10}.age == 33
    assert joe.age == :__
  end

  koan "you can pattern match into the fields of a struct" do
    %Person{age: age} = %Person{age: 22, name: "Silvia"}
    assert age == :__
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end

  koan "or onto the type of the struct itself" do
    assert is_a_plane(%Plane{passengers: 417, maker: :boeing}) == :__
  end

  def is_a_plane(%Plane{}), do: true

  koan "are basically maps" do
    silvia = %Person{age: 22, name: "Silvia"}

    assert Map.fetch!(silvia, :age) == :__
  end
end
