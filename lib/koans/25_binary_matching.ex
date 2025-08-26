defmodule BinaryMatching do
  @moduledoc false
  use Koans

  @intro "Binary Pattern Matching - Working with raw bytes and binary data"

  koan "Binaries are sequences of bytes" do
    binary = <<1, 2, 3>>
    assert byte_size(binary) == ___
  end

  koan "Strings are UTF-8 encoded binaries" do
    string = "hello"
    assert is_binary(string) == ___
    assert byte_size(string) == ___
  end

  koan "You can pattern match on binary prefixes" do
    <<"Hello", rest::binary>> = "Hello, World!"
    assert rest == ___
  end

  koan "Binary pattern matching can extract specific bytes" do
    <<first, second, rest::binary>> = <<65, 66, 67, 68>>
    assert first == ___
    assert second == ___
    assert rest == ___
  end

  koan "String pattern matching works with binary syntax" do
    <<"HTTP/", version::binary-size(3), " ", status::binary-size(3), " ", message::binary>> =
      "HTTP/1.1 200 OK"

    assert version == ___
    assert status == ___
    assert message == ___
  end

  koan "You can match on specific bit patterns" do
    <<flag::1, counter::7>> = <<200>>
    assert flag == ___
    assert counter == ___
  end

  koan "Endianness can be specified for multi-byte integers" do
    <<number::16-little>> = <<1, 2>>
    assert number == ___

    <<number::16-big>> = <<1, 2>>
    assert number == ___
  end

  koan "You can construct binaries with specific values" do
    binary = <<255, 0, 128>>
    <<high, low, middle>> = binary
    assert high == ___
    assert low == ___
    assert middle == ___
  end

  koan "Float values can be packed into binaries" do
    <<value::32-float>> = <<66, 246, 0, 0>>
    assert Float.round(value, 1) == ___
  end

  # I think this is trying to cover https://hexdocs.pm/elixir/main/comprehensions.html#bitstring-generators
  # but the syntax is apparently wrong...
  # TODO: investigate
  # koan "Binary comprehensions can create patterns" do
  #  result = for <<byte <- <<1, 2, 3, 4>>, byte > 2>>, do: byte * 2
  #  assert result == ___
  # end

  # TODO: investigate syntax here. It's erroring currently
  # koan "You can parse CSV-like data with binary matching" do
  #  parse_csv_line = fn line ->
  #    String.split(String.trim(line), ",")
  #    |> Enum.map(&String.trim/1)
  #  end

  #  # But with binary matching for more control:
  #  parse_field = fn
  #    <<"\"", field::binary-size(n), "\"", _::binary>> when byte_size(field) > 0 -> field
  #    <<field::binary>> -> String.trim(field)
  #  end

  #  result = parse_csv_line.("Alice, 30, Engineer")
  #  assert result == ___
  # end

  koan "IP address parsing with binary patterns" do
    parse_ipv4 = fn ip_string ->
      case String.split(ip_string, ".") do
        [a, b, c, d] ->
          <<String.to_integer(a), String.to_integer(b), String.to_integer(c),
            String.to_integer(d)>>

        _ ->
          :error
      end
    end

    <<a, b, c, d>> = parse_ipv4.("192.168.1.1")
    assert a == ___
    assert b == ___
    assert c == ___
    assert d == ___
  end

  koan "Binary matching can validate data formats" do
    is_png? = fn
      <<137, 80, 78, 71, 13, 10, 26, 10, _::binary>> -> true
      _ -> false
    end

    png_header = <<137, 80, 78, 71, 13, 10, 26, 10, "fake data">>
    jpeg_header = <<255, 216, 255, "fake data">>

    assert is_png?.(png_header) == ___
    assert is_png?.(jpeg_header) == ___
  end

  koan "You can extract length-prefixed strings" do
    parse_length_string = fn
      <<length::8, string::binary-size(length), rest::binary>> ->
        {string, rest}

      _ ->
        :error
    end

    data = <<5, "Hello", "World">>
    {extracted, remaining} = parse_length_string.(data)
    assert extracted == ___
    assert remaining == ___
  end

  koan "Binary matching works with hexadecimal literals" do
    <<red::8, green::8, blue::8>> = <<0xFF, 0x80, 0x00>>
    assert red == ___
    assert green == ___
    assert blue == ___
  end

  koan "You can match variable-length binary data" do
    extract_until_delimiter = fn binary, delimiter ->
      case :binary.split(binary, delimiter) do
        [a, b] -> {a, b}
        [_] -> {binary, ""}
      end
    end

    {a, b} = extract_until_delimiter.("name=John&age=30", "&")
    assert a == ___
    assert b == ___
  end

  koan "Binary matching can parse simple protocols" do
    parse_message = fn
      <<1, length::16, payload::binary-size(length)>> ->
        {:text, payload}

      <<2, length::16, payload::binary-size(length)>> ->
        {:binary, payload}

      <<3>> ->
        :ping

      _ ->
        :unknown
    end

    text_msg = <<1, 0, 5, "Hello">>
    ping_msg = <<3>>

    assert parse_message.(text_msg) == ___
    assert parse_message.(ping_msg) == ___
  end

  koan "String interpolation creates binaries" do
    name = "Alice"
    age = 30
    message = "Hello #{name}, you are #{age} years old"

    <<"Hello ", rest::binary>> = message
    assert rest == ___
  end

  koan "Binary pattern matching can validate checksums" do
    validate_checksum = fn <<data::binary-size(4), checksum::8>> ->
      calculated =
        data
        |> :binary.bin_to_list()
        |> Enum.sum()
        |> rem(256)

      calculated == checksum
    end

    # Data: [1,2,3,4], sum = 10, checksum = 10
    valid_packet = <<1, 2, 3, 4, 10>>
    invalid_packet = <<1, 2, 3, 4, 20>>

    assert validate_checksum.(valid_packet) == ___
    assert validate_checksum.(invalid_packet) == ___
  end

  koan "You can work with null-terminated strings" do
    parse_c_string = fn binary ->
      case :binary.split(binary, <<0>>) do
        [string, _rest] -> string
        [string] -> string
      end
    end

    c_string = <<"Hello World", 0, "ignored">>
    result = parse_c_string.(c_string)
    assert result == ___
  end

  koan "Binary construction and pattern matching are symmetric" do
    # Construction
    packet = <<42::16, "Hello", 0>>

    # Deconstruction  
    <<id::16, message::binary-size(5), terminator::8>> = packet

    assert id == ___
    assert message == ___
    assert terminator == ___
  end
end
