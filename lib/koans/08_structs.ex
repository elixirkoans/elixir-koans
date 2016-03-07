defmodule Structs do
  use Koans

  defmodule Person do
    defstruct [:name, :age ]
  end

  koan "structs are defined and named after a module" do
    assert %Person{}
  end

  koan "you can access the fields of a struct" do
    nobody = %Person{}
    assert nobody.age == nil
    assert nobody.name == nil
  end

  koan "You can pass initial values to structs" do
    joe = %Person{name: "Joe", age: 23}
    assert joe.age == 23
    assert joe.name == "Joe"
  end

  koan "update fields with the pipe '|' operator" do
    joe = %Person{name: "Joe", age: 23}
    older = %{ joe | age: joe.age + 10}
    assert  older.age == 33
  end

  koan "the original struct is not affected by updates" do
    joe = %Person{name: "Joe", age: 23}
    assert %{ joe | age: joe.age + 10}.age == 33
    assert joe.age == 23
  end

  koan "you can pattern match into the fields of a struct" do
    %Person{age: age} = %Person{age: 22, name: "Silvia"}
    assert age == 22
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end

  koan "or onto the type of the struct itself" do
    assert is_a_plane(%Plane{passengers: 417, maker: :boeing})
    refute is_a_plane(%Person{age: 22, name: "Silvia"})
  end

  def is_a_plane(%Plane{}), do: true
  def is_a_plane(_), do: false

  koan "are basically maps" do
    silvia = %Person{age: 22, name: "Silvia"}

    assert is_map(silvia)
    assert Map.fetch!(silvia, :age) == 22
  end
end
