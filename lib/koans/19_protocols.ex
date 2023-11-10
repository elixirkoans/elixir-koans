defmodule Protocols do
  @moduledoc false
  use Koans

  @intro "Want to follow the rules? Adhere to the protocol!"

  defprotocol(Artist, do: def(perform(artist)))

  defimpl Artist, for: Any do
    def perform(_) do
      "Artist showed performance"
    end
  end

  defmodule Painter do
    @moduledoc false
    @derive Artist
    defstruct name: ""
  end

  defmodule Musician do
    @moduledoc false
    defstruct(name: "", instrument: "")
  end

  defmodule Dancer do
    @moduledoc false
    defstruct(name: "", dance_style: "")
  end

  defmodule Physicist do
    @moduledoc false
    defstruct(name: "")
  end

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

    assert Artist.perform(musician) == ___
    assert Artist.perform(dancer) == ___
  end

  koan "Sometimes we all use the same" do
    painter = %Painter{name: "Emily"}
    assert Artist.perform(painter) == ___
  end

  koan "If you are not an artist, you can't show performance" do
    assert_raise ___, fn ->
      Artist.perform(%Physicist{name: "Delia"})
    end
  end
end
