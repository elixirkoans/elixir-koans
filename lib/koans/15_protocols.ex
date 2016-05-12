defmodule Protocols do
  use Koans

  defprotocol School do
    def enrol(name)
  end

  defimpl School, for: SecondarySchool do
    def enrol(name) do
      "#{name} enrolled at secondary school"
    end
  end

  defimpl School, for: DanceSchool do
    def enrol(name) do
      "#{name} enrolled for dance"
    end
  end

  defmodule EveningClass do end

  @schools %{
    :secondary => School.SecondarySchool,
    :dance => School.DanceSchool,
    :evening => EveningClass
  }

  koan "Commonality is the secret" do
    school = Map.get(@schools, :dance)
    assert school.enrol("Emily") == ___
  end

  koan "When there is a difference there is no way" do
    assert_raise ___, fn ->
      school = Map.get(@schools, :evening)
      school.enrol("bob")
    end
  end
end
