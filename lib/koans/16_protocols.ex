defmodule Protocols do
  use Koans

  @intro "Protocols"

  defprotocol School, do: def enrol(person)

  defmodule Student, do: defstruct name: ""
  defmodule Baker, do: defstruct name: ""
  defmodule Dancer do
    defstruct name: "", dance_style: ""
  end

  defimpl School, for: Student do
    def enrol(student), do: "#{student.name} enrolled at secondary school"
  end

  defimpl School, for: Dancer do
    def enrol(dancer), do: "#{dancer.name} enrolled for #{dancer.dance_style}"
  end

  koan "Sharing an interface is the secret at school" do
    student = %Student{name: "Emily"}
    dancer = %Dancer{name: "Darcy", dance_style: "ballet"}

    assert School.enrol(student) == ___
    assert School.enrol(dancer) == ___
  end

  koan "If you don't comply you can't get in" do
    assert_raise ___, fn ->
      School.enrol(%Baker{name: "Delia"})
    end
  end
end
