defmodule IOAndFiles do
  @moduledoc false
  use Koans

  @intro "IO and Files - Reading, writing, and interacting with the outside world"

  koan "IO.puts writes to standard output" do
    # We can't easily test stdout, but we can test the return value
    result = IO.puts("Hello, World!")
    assert result == ___
  end

  koan "IO.inspect returns its input while printing it" do
    value = [1, 2, 3]
    result = IO.inspect(value)
    assert result == ___
  end

  koan "IO.inspect can be customized with options" do
    data = %{name: "Alice", details: %{age: 30, city: "Boston"}}
    result = IO.inspect(data, label: "User Data", pretty: true)
    assert result == ___
  end

  koan "File.read/1 reads entire files" do
    # Let's create a temporary file for testing
    content = "Hello from file!"
    File.write!("/tmp/test_koan.txt", content)

    result = File.read("/tmp/test_koan.txt")
    assert result == ___

    # Clean up
    File.rm("/tmp/test_koan.txt")
  end

  koan "File.read/1 returns error tuples for missing files" do
    result = File.read("/tmp/nonexistent_file.txt")
    assert elem(result, 0) == ___
  end

  koan "File.read!/1 raises exceptions for errors" do
    assert_raise File.Error, fn ->
      File.read!("/tmp/___")
    end
  end

  koan "File.write/2 creates and writes to files" do
    path = "/tmp/write_test.txt"
    content = "This is test content"

    result = File.write(path, content)
    assert result == ___

    # Verify it was written
    {:ok, read_content} = File.read(path)
    assert read_content == ___

    File.rm(path)
  end

  koan "File operations can be chained for processing" do
    path = "/tmp/chain_test.txt"
    original = "hello world"

    result =
      path
      |> File.write(original)
      |> case do
        :ok -> File.read(path)
        error -> error
      end
      |> case do
        {:ok, content} -> String.upcase(content)
        error -> error
      end

    assert result == ___
    File.rm(path)
  end

  koan "File.exists?/1 checks if files exist" do
    path = "/tmp/existence_test.txt"

    assert File.exists?(path) == ___

    File.write!(path, "content")
    assert File.exists?(path) == ___

    File.rm!(path)
    assert File.exists?(path) == ___
  end

  koan "File.ls/1 lists directory contents" do
    # Create a test directory with some files
    dir = "/tmp/test_dir_koan"
    File.mkdir_p!(dir)
    File.write!("#{dir}/file1.txt", "content1")
    File.write!("#{dir}/file2.txt", "content2")

    {:ok, files} = File.ls(dir)
    sorted_files = Enum.sort(files)

    assert sorted_files == ___

    # Clean up
    File.rm_rf!(dir)
  end

  koan "Path module helps with file path operations" do
    path = Path.join(["/", "home", "user", "documents"])
    assert path == ___

    basename = Path.basename("/home/user/file.txt")
    assert basename == ___

    dirname = Path.dirname("/home/user/file.txt")
    assert dirname == ___

    extension = Path.extname("document.pdf")
    assert extension == ___
  end

  koan "File.stream! creates lazy streams for large files" do
    path = "/tmp/stream_test.txt"
    content = "line 1\nline 2\nline 3\n"
    File.write!(path, content)

    line_count =
      path
      |> File.stream!()
      |> Enum.count()

    assert line_count == ___

    first_line =
      path
      |> File.stream!()
      |> Enum.take(1)
      |> List.first()
      |> String.trim()

    assert first_line == ___

    File.rm!(path)
  end

  koan "IO.StringIO creates in-memory IO devices" do
    {:ok, string_io} = StringIO.open("initial content")

    # Read from it
    content = IO.read(string_io, :all)
    assert content == ___

    # Write to it
    IO.write(string_io, " added content")

    # Get the full content
    {_input, output} = StringIO.contents(string_io)
    assert output == ___

    StringIO.close(string_io)
  end

  koan "File.cp/2 and File.mv/2 copy and move files" do
    source = "/tmp/source.txt"
    copy_dest = "/tmp/copy.txt"
    move_dest = "/tmp/moved.txt"

    File.write!(source, "original content")

    # Copy file
    result = File.cp(source, copy_dest)
    assert result == ___
    assert File.read!(copy_dest) == ___

    # Move file
    result = File.mv(copy_dest, move_dest)
    assert result == ___
    assert File.exists?(copy_dest) == ___
    assert File.exists?(move_dest) == ___

    # Clean up
    File.rm!(source)
    File.rm!(move_dest)
  end

  koan "File.stat/1 provides file information" do
    path = "/tmp/stat_test.txt"
    File.write!(path, "some content for stat testing")

    {:ok, stat} = File.stat(path)

    assert stat.type == ___
    assert stat.size > 0 == ___
    assert is_integer(stat.mtime) == ___

    File.rm!(path)
  end

  koan "File operations handle directory creation" do
    dir_path = "/tmp/nested/deep/directory"

    # mkdir_p creates parent directories
    result = File.mkdir_p(dir_path)
    assert result == ___
    assert File.dir?(dir_path) == ___

    # Regular mkdir fails if parents don't exist
    another_nested = "/tmp/another/nested"
    result = File.mkdir(another_nested)
    assert elem(result, 0) == ___

    # Clean up
    File.rm_rf!("/tmp/nested")
  end

  koan "IO.getn prompts for user input" do
    # We can't easily test interactive input, but we can test with StringIO
    {:ok, input_device} = StringIO.open("test input")

    result = IO.getn(input_device, "Enter text: ", 4)
    assert result == ___

    StringIO.close(input_device)
  end

  koan "File.open/2 provides more control over file operations" do
    path = "/tmp/open_test.txt"

    # Open file for writing
    {:ok, file} = File.open(path, [:write])
    IO.write(file, "Written with File.open")
    File.close(file)

    # Open file for reading
    {:ok, file} = File.open(path, [:read])
    content = IO.read(file, :all)
    File.close(file)

    assert content == ___

    File.rm!(path)
  end

  koan "File operations can work with binary data" do
    path = "/tmp/binary_test.bin"
    binary_data = <<1, 2, 3, 4, 255>>

    File.write!(path, binary_data)
    read_data = File.read!(path)

    assert read_data == ___
    assert byte_size(read_data) == ___

    File.rm!(path)
  end

  koan "Temporary files can be created safely" do
    # Create a temporary file using our helper
    path = temp_path()
    File.write!(path, "temporary content")

    assert File.exists?(path) == ___
    content = File.read!(path)
    assert content == ___

    File.rm!(path)
  end

  # Helper function to create temp paths since we don't have Temp module
  defp temp_path do
    "/tmp/koan_temp_#{:rand.uniform(10000)}.txt"
  end

  koan "File.touch/1 creates empty files or updates timestamps" do
    path = temp_path()

    # Create file
    result = File.touch(path)
    assert result == ___
    assert File.exists?(path) == ___

    # File should be empty
    content = File.read!(path)
    assert content == ___

    File.rm!(path)
  end

  koan "Working with CSV-like data using File.stream!" do
    path = "/tmp/csv_test.csv"
    csv_content = "name,age,city\nAlice,30,Boston\nBob,25,Seattle\nCharlie,35,Austin"
    File.write!(path, csv_content)

    parsed_data =
      path
      |> File.stream!()
      # Skip header
      |> Stream.drop(1)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, ","))
      |> Enum.to_list()

    first_record = List.first(parsed_data)
    assert first_record == ___
    assert length(parsed_data) == ___

    File.rm!(path)
  end
end
