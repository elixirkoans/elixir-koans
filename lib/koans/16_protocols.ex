defmodule Protocols do
  use Koans

  defprotocol School do
    def enrol(person)
  end

  defmodule Student do
    defstruct name: ""
  end

  defmodule Dancer do
    defstruct name: "", dance_style: ""
  end

  defmodule Baker do
    defstruct name: ""
  end

  defimpl School, for: Student do
    def enrol(student) do
      "#{student.name} enrolled at secondary school"
    end
  end

  defimpl School, for: Dancer do
    def enrol(dancer) do
      "#{dancer.name} enrolled for #{dancer.dance_style}"
    end
  end

  defmodule EveningSchool do end

  koan "Sharing an interface is the secret at school" do
    student = %Student{name: "Emily"}
    assert School.enrol(student) == ___
  end

  koan "Dancers share but belong to a different school" do
    dancer = %Dancer{name: "Darcy", dance_style: "ballet"}
    assert School.enrol(dancer) == ___

  end

  koan "If you don't comply you can't get in" do
    assert_raise ___, fn ->
      School.enrol(%Baker{name: "Delia"})
    end
  end
end
