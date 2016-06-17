defmodule Protocols do
  use Koans

  @intro "Want to follow the rules? Adhere to the protocol!"

  defprotocol School, do: def enrol(person)

  defimpl School, for: Any do
    def enrol(_) do
      "Pupil enrolled at school"
    end
  end

  defmodule Student do
    @derive School
    defstruct name: ""
  end

  defmodule Musician, do: defstruct name: "", instrument: ""
  defmodule Dancer,  do: defstruct name: "", dance_style: ""
  defmodule Baker, do: defstruct name: ""

  defimpl School, for: Musician do
    def enrol(musician) do
      "#{musician.name} signed up for #{musician.instrument}"
    end
  end

  defimpl School, for: Dancer do
    def enrol(dancer), do: "#{dancer.name} enrolled for #{dancer.dance_style}"
  end

  koan "Sharing an interface is the secret at school" do
    musician = %Musician{name: "Andre", instrument: "violin"}
    dancer = %Dancer{name: "Darcy", dance_style: "ballet"}

    assert School.enrol(musician) == ___
    assert School.enrol(dancer) == ___
  end

  koan "Sometimes we all use the same" do
    student = %Student{name: "Emily"}
    assert School.enrol(student) == ___
  end

  koan "If you don't comply you can't get in" do
    assert_raise ___, fn ->
      School.enrol(%Baker{name: "Delia"})
    end
  end
end
