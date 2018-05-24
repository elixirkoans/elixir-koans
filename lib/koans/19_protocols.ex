defmodule Protocols do
  use Koans

  @intro "Want to follow the rules? Adhere to the protocol!"

  defprotocol(School, do: def(enroll(person)))

  defimpl School, for: Any do
    def enroll(_) do
      "Pupil enrolled at school"
    end
  end

  defmodule Student do
    @derive School
    defstruct name: ""
  end

  defmodule(Musician, do: defstruct(name: "", instrument: ""))
  defmodule(Dancer, do: defstruct(name: "", dance_style: ""))
  defmodule(Baker, do: defstruct(name: ""))

  defimpl School, for: Musician do
    def enroll(musician) do
      "#{musician.name} signed up for #{musician.instrument}"
    end
  end

  defimpl School, for: Dancer do
    def enroll(dancer), do: "#{dancer.name} enrolled for #{dancer.dance_style}"
  end

  koan "Sharing an interface is the secret at school" do
    musician = %Musician{name: "Andre", instrument: "violin"}
    dancer = %Dancer{name: "Darcy", dance_style: "ballet"}

    assert School.enroll(musician) == ___
    assert School.enroll(dancer) == ___
  end

  koan "Sometimes we all use the same" do
    student = %Student{name: "Emily"}
    assert School.enroll(student) == ___
  end

  koan "If you don't comply you can't get in" do
    assert_raise ___, fn ->
      School.enroll(%Baker{name: "Delia"})
    end
  end
end
