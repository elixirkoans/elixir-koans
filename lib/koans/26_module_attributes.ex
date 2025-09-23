defmodule ModuleAttributes do
  @moduledoc """
  This module demonstrates various types of module attributes in Elixir.
  Module attributes provide metadata and compile-time configuration.
  """
  use Koans

  @intro "Module Attributes - Metadata, documentation, and compile-time values"

  # Compile-time constant
  @default_timeout 5000

  # Documentation attributes
  @doc "A simple function that returns a greeting"
  @spec greet(String.t()) :: String.t()
  def greet(name) do
    "Hello, #{name}!"
  end

  koan "Module attributes can store compile-time constants" do
    assert @default_timeout == ___
  end

  # Type specifications
  @type user :: %{name: String.t(), age: integer()}
  @type result :: {:ok, any()} | {:error, String.t()}

  @doc "Creates a new user with validation"
  @spec create_user(String.t(), integer()) :: result()
  def create_user(name, age) when is_binary(name) and is_integer(age) and age >= 0 do
    {:ok, %{name: name, age: age}}
  end

  def create_user(_, _), do: {:error, "Invalid user data"}

  koan "Module attributes can define custom types" do
    user = %{name: "Alice", age: 30}
    assert user.name == ___
    assert user.age == ___
  end

  # Accumulating attributes
  @tag :important
  @tag :deprecated
  @tag :experimental

  koan "Some attributes accumulate values when defined multiple times" do
    tags = Module.get_attribute(__MODULE__, :tag)
    assert :important in tags == ___
    assert :experimental in tags == ___
    assert length(tags) == ___
  end

  # Dynamic attribute calculation
  @compile_time :os.timestamp()

  koan "Attributes are evaluated at compile time" do
    # This will be whatever timestamp was captured when the module compiled
    assert is_tuple(@compile_time) == ___
  end

  # Attribute with default value pattern
  @config Application.compile_env(:my_app, :config, %{timeout: 1000})

  koan "Attributes can have default values from application config" do
    assert @config.timeout == ___
  end

  # Using attributes in function heads
  @max_retries 3

  @doc "Retries an operation up to the configured maximum"
  @spec retry_operation(function(), non_neg_integer()) :: any()
  def retry_operation(operation, attempts \\ 0)
  def retry_operation(operation, @max_retries), do: {:error, :max_retries_reached}

  def retry_operation(operation, attempts) do
    case operation.() do
      {:ok, result} -> {:ok, result}
      {:error, _} -> retry_operation(operation, attempts + 1)
    end
  end

  koan "Attributes can be used in pattern matching in function definitions" do
    failing_op = fn -> {:error, :simulated_failure} end
    result = retry_operation(failing_op)
    assert result == ___
  end

  # Custom attribute with register
  Module.register_attribute(__MODULE__, :custom_metadata, accumulate: true)
  @custom_metadata {:version, "1.0.0"}
  @custom_metadata {:author, "Anonymous"}

  koan "Custom attributes can be registered and accumulated" do
    metadata = Module.get_attribute(__MODULE__, :custom_metadata)
    version_tuple = Enum.find(metadata, fn {key, _} -> key == :version end)
    assert version_tuple == ___
  end

  # Attribute access in guards
  @min_age 18

  @doc "Checks if a person is an adult"
  @spec adult?(integer()) :: boolean()
  def adult?(age) when age >= @min_age, do: true
  def adult?(_), do: false

  koan "Attributes can be used in guard expressions" do
    assert adult?(25) == ___
    assert adult?(16) == ___
  end

  # External file reading at compile time
  # This tells the compiler to recompile if README.md changes
  @external_resource "README.md"
  # @version File.read!("VERSION") |> String.trim()  # Would read version from file

  # Since we don't have these files, let's simulate:
  @version "1.2.3"

  koan "Attributes can read external files at compile time" do
    assert @version == ___
  end

  # Conditional compilation
  @compile_env Mix.env()

  if @compile_env == :dev do
    @doc "This function only exists in development"
    def debug_info, do: "Development mode: #{@compile_env}"
  end

  koan "Attributes enable conditional compilation" do
    # This will depend on the compilation environment
    assert @compile_env in [:dev, :test, :prod] == ___
  end

  # Behaviour callbacks documentation
  @doc """
  This would be a callback definition if we were defining a behaviour.
  Behaviours use @callback to define the functions that must be implemented.
  """
  # @callback handle_event(event :: any(), state :: any()) :: {:ok, any()} | {:error, String.t()}

  # Module attribute for configuration
  @dialyzer {:no_return, deprecated_function: 0}

  # This hides the function from documentation
  @doc false
  def deprecated_function do
    raise "This function is deprecated"
  end

  koan "The module attribute @doc false hides functions from generated documentation" do
    # The function exists but won't appear in docs
    assert function_exported?(__MODULE__, :deprecated_function, 0) == ___
  end

  # Attribute computed from other attributes
  @base_url "https://api.example.com"
  @api_version "v1"
  @full_url "#{@base_url}/#{@api_version}"

  koan "Attributes can be computed from other attributes" do
    assert @full_url == ___
  end

  # Using attributes for code generation
  @fields [:name, :email, :age]

  Enum.each(@fields, fn field ->
    def unquote(:"get_#{field}")(user) do
      Map.get(user, unquote(field))
    end
  end)

  koan "Attributes can drive code generation with macros" do
    user = %{name: "Bob", email: "bob@example.com", age: 35}
    assert get_name(user) == ___
    assert get_email(user) == ___
    assert get_age(user) == ___
  end

  # Storing complex data structures
  @lookup_table %{
    :red => "#FF0000",
    :green => "#00FF00",
    :blue => "#0000FF"
  }

  @doc "Converts color names to hex codes"
  @spec color_to_hex(atom()) :: String.t() | nil
  def color_to_hex(color) do
    Map.get(@lookup_table, color)
  end

  koan "Attributes can store complex data structures" do
    assert color_to_hex(:red) == ___
    assert color_to_hex(:purple) == ___
  end

  # Multiple type specs for the same function
  @doc "Processes different types of input"
  @spec process_input(String.t()) :: String.t()
  @spec process_input(integer()) :: integer()
  @spec process_input(list()) :: list()
  def process_input(input) when is_binary(input), do: String.upcase(input)
  def process_input(input) when is_integer(input), do: input * 2
  def process_input(input) when is_list(input), do: Enum.reverse(input)

  koan "Functions can have multiple type specifications" do
    assert process_input("hello") == ___
    assert process_input(5) == ___
    assert process_input([1, 2, 3]) == ___
  end
end
