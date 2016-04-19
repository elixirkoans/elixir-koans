defmodule Structs do
  use Koans

  defmodule Person do
    defstruct [:name, :age ]
  end

  koan "Structs are defined and named after a module" do
    person = %Person{}
    assert person == __
  end

  koan "You can access the fields of a struct" do
    nobody = %Person{}
    assert nobody.age == __
  end

  koan "You can pass initial values to structs" do
    joe = %Person{name: "Joe", age: 23}
    assert joe.name == __
  end

  koan "Update fields with the pipe '|' operator" do
    joe = %Person{name: "Joe", age: 23}
    older = %{ joe | age: joe.age + 10}
    assert older.age == __
  end

  koan "The original struct is not affected by updates" do
    joe = %Person{name: "Joe", age: 23}
    assert %{ joe | age: joe.age + 10}.age == __
    assert joe.age == __
  end

  koan "You can pattern match into the fields of a struct" do
    %Person{age: age} = %Person{age: 22, name: "Silvia"}
    assert age == __
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end

  def plane?(%Plane{}), do: true
  def plane?(_), do: false

  koan "Or onto the type of the struct itself" do
    assert plane?(%Plane{passengers: 417, maker: :boeing}) == __
    assert plane?(%Person{}) == __
  end


  koan "Are basically maps" do
    silvia = %Person{age: 22, name: "Silvia"}

    assert Map.fetch!(silvia, :age) == __
  end
end
