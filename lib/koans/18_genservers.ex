defmodule GenServers do
  use Koans

  @intro "GenServers"

  defmodule Laptop do
    use GenServer

    #####
    # External API
    def init(args) do
      {:ok, args}
    end

    def start_link(init_password) do
      # The __MODULE__ macro returns the current module name as an atom
      GenServer.start_link(__MODULE__, init_password, name: __MODULE__)
    end

    def unlock(password) do
      GenServer.call(__MODULE__, {:unlock, password})
    end

    def owner_name do
      GenServer.call(__MODULE__, :get_owner_name)
    end

    def manufacturer do
      GenServer.call(__MODULE__, :get_manufacturer)
    end

    def laptop_type do
      GenServer.call(__MODULE__, :get_type)
    end

    def retrieve_password do
      GenServer.call(__MODULE__, :get_password)
    end

    def laptop_specs do
      GenServer.call(__MODULE__, :get_specs)
    end

    def change_password(old_password, new_password) do
      GenServer.cast(__MODULE__, {:change_password, old_password, new_password})
    end

    ####
    # GenServer implementation

    def handle_call(:get_password, _from, current_password) do
      {:reply, current_password, current_password}
    end

    def handle_call(:get_manufacturer, _from, current_state) do
      {:reply, "Apple Inc.", current_state}
    end

    def handle_call(:get_type, _from, current_state) do
      {:reply, "MacBook Pro", current_state}
    end

    def handle_call(:get_owner_name, _from, current_state) do
      {:reply, {:ok, "Jack Sparrow"}, current_state}
    end

    def handle_call(:get_specs, _from, current_state) do
      {:reply, {:ok, ["2.9 GHz Intel Core i5"], 8192, :intel_iris_graphics}, current_state}
    end

    def handle_call(:name_check, _from, current_state) do
      {:reply, "Congrats! Your process was successfully named.", current_state}
    end

    def handle_call({:unlock, password}, _from, current_password) do
      case password do
        password when password === current_password ->
          {:reply, {:ok, "Laptop unlocked!"}, current_password}

        _ ->
          {:reply, {:error, "Incorrect password!"}, current_password}
      end
    end

    def handle_cast({:change_password, old_password, new_password}, current_password) do
      case old_password do
        old_password when old_password == current_password ->
          {:noreply, new_password}

        _ ->
          {:noreply, current_password}
      end
    end
  end

  koan "Servers that are created and initialized successfully returns a tuple that holds the PID of the server" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    assert is_pid(pid) == true
  end

  koan "The handle_call callback is synchronous so it will block until a reply is received" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    assert GenServer.call(pid, :get_password) == "3kr3t!"
  end

  koan "A server can support multiple actions by implementing multiple handle_call functions" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    assert GenServer.call(pid, :get_manufacturer) == "Apple Inc."
    assert GenServer.call(pid, :get_type) == "MacBook Pro"
  end

  koan "A handler can return multiple values and of different types" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    {:ok, processor, memory, graphics} = GenServer.call(pid, :get_specs)
    assert processor == ["2.9 GHz Intel Core i5"]
    assert memory == 8192
    assert graphics == :intel_iris_graphics
  end

  koan "The handle_cast callback handles asynchronous messages" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    GenServer.cast(pid, {:change_password, "3kr3t!", "73x7!n9"})
    assert GenServer.call(pid, :get_password) == "73x7!n9"
  end

  koan "Handlers can also return error responses" do
    {:ok, pid} = GenServer.start_link(Laptop, "3kr3t!")
    assert GenServer.call(pid, {:unlock, "81u3pr!n7"}) == {:error, "Incorrect password!"}
  end

  koan "Referencing processes by their PID gets old pretty quickly, so let's name them" do
    {:ok, _} = GenServer.start_link(Laptop, "3kr3t!", name: :macbook)
    assert GenServer.call(:macbook, :name_check) == "Congrats! Your process was successfully named."
  end

  koan "Our server works but it's pretty ugly to use; so lets use a cleaner interface" do
    Laptop.start_link("EL!73")
    assert Laptop.unlock("EL!73") == {:ok, "Laptop unlocked!"}
  end

  koan "Let's use the remaining functions in the external API" do
    Laptop.start_link("EL!73")
    {_, response} = Laptop.unlock("EL!73")
    assert response == "Laptop unlocked!"

    Laptop.change_password("EL!73", "Elixir")
    {_, response} = Laptop.unlock("EL!73")
    assert response == "Incorrect password!"

    {_, response} = Laptop.owner_name()
    assert response == "Jack Sparrow"
  end
end
