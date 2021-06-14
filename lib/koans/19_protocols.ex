defmodule Protocols do
  use Koans

  @intro "Want to follow the rules? Adhere to the protocol!"

  defprotocol(Artist, do: def(perform(artist)))

  defimpl Artist, for: Any do
    def perform(_) do
      "Artist showed performance"
    end
  end

  defmodule Painter do
    @derive Artist
    defstruct name: ""
  end

  defmodule(Musician, do: defstruct(name: "", instrument: ""))
  defmodule(Dancer, do: defstruct(name: "", dance_style: ""))
  defmodule(Physicist, do: defstruct(name: ""))

  defimpl Artist, for: Musician do
    def perform(musician) do
      "#{musician.name} played #{musician.instrument}"
    end
  end

  defimpl Artist, for: Dancer do
    def perform(dancer), do: "#{dancer.name} performed #{dancer.dance_style}"
  end

  koan "Sharing an interface is the secret at school" do
    musician = %Musician{name: "Andre", instrument: "violin"}
    dancer = %Dancer{name: "Darcy", dance_style: "ballet"}

    assert Artist.perform(musician) == "Andre played violin"
    assert Artist.perform(dancer) == "Darcy performed ballet"
  end

  koan "Sometimes we all use the same" do
    painter = %Painter{name: "Emily"}
    assert Artist.perform(painter) == "Artist showed performance"
  end

  koan "If you are not an artist, you can't show performance" do
    assert_raise Protocol.UndefinedError, fn ->
      Artist.perform(%Physicist{name: "Delia"})
    end
  end
end
