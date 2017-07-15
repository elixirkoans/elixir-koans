defmodule GenServers do
  use Koans

  @intro "GenServers"

  defmodule BicycleLock do
    use GenServer

    #####
    # External API

    def start_link(init_password) do
      # The __MODULE__ macro returns the current module name as an atom
      GenServer.start_link(__MODULE__, init_password, name: __MODULE__)
    end

    def unlock(password) do
      GenServer.call(__MODULE__, {:unlock, password})
    end

    def change_password(old_password, new_password) do
      GenServer.cast(__MODULE__, {:change_password, old_password, new_password})
    end

    def owner_info do
      GenServer.call(__MODULE__, :get_owner_info)
    end

    ####
    # GenServer implementation
    
    def handle_call(:get_password, _from, current_password) do
     {:reply, current_password, current_password} 
    end

    def handle_call(:get_bike_brand, _from, current_state) do
      {:reply, "Tribe Bicycle Co.", current_state}
    end

    def handle_call(:get_bike_name, _from, current_state) do
      {:reply, "CRMO Series", current_state}
    end

    def handle_call(:get_owner_info, _from, current_state) do
      {:reply, {:ok, "Argh...Jack Sparrow's password is: #{current_state}"}, current_state}
    end

    def handle_call(:get_multi, _from, current_state) do
      {:reply, {:ok, ["this", "is", "sparta"], 369, :hello_world}, current_state}
    end

    def handle_call(:name_check, _from, current_state) do
      {:reply, "Congrats! Your process was successfully named.", current_state}
    end
    
    def handle_call({:unlock, password}, _from, current_password) do
      case password do
        password when password === current_password ->
          {:reply, {:ok, "Bicycle unlocked!"}, current_password}
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
    {:ok, pid} = GenServer.start_link(BicycleLock, nil)
    assert is_pid(pid) == ___
  end

  koan "When starting a GenServer you can set it's initial state" do
    {:ok, pid} = GenServer.start_link(BicycleLock, "3kr3t!")
    assert GenServer.call(pid, :get_password) == ___
  end

  koan "The handle_call callback is synchronous so it will block until a reply is received" do
    {:ok, pid} = GenServer.start_link(BicycleLock, "3kr3t!")
    assert GenServer.call(pid, :get_password) == ___
  end

  koan "A server can support multiple actions by implementing multiple handle_call functions" do
    {:ok, pid} = GenServer.start_link(BicycleLock, nil)
    assert GenServer.call(pid, :get_bike_brand) == ___
    assert GenServer.call(pid, :get_bike_name) == ___
  end

  koan "A handler can return multiple values and of different types" do
    {:ok, pid} = GenServer.start_link(BicycleLock, nil)
    {:ok, string_list, num, atom} = GenServer.call(pid, :get_multi)
    assert string_list == ___
    assert num == ___
    assert atom == ___
  end

  koan "The handle_cast callback handles asynchronous messages" do
    {:ok, pid} = GenServer.start_link(BicycleLock, "3kr3t!")
    GenServer.cast(pid, {:change_password, "3kr3t!", "Hello"})
    assert GenServer.call(pid, :get_password) == ___
  end

  koan "Handlers can also return error responses" do
    {:ok, pid} = GenServer.start_link(BicycleLock, "3kr3t!")
    assert GenServer.call(pid, {:unlock, 2017}) == ___
  end

  koan "Referencing processes by their PID gets old pretty quickly, so let's name them" do
    {:ok, _} = GenServer.start_link(BicycleLock, nil, name: :bike_lock)
    assert GenServer.call(:bike_lock, :name_check) == ___
  end

  koan "Our server works but it's pretty ugly to use; so lets use a cleaner interface" do
    BicycleLock.start_link("EL!73")
    assert BicycleLock.unlock("EL!73") == ___
  end

  koan "Let's use the remaining functions in the external API" do
    BicycleLock.start_link("EL!73")
    {_, response} = BicycleLock.unlock("EL!73")
    assert response == ___

    BicycleLock.change_password("EL!73", "Elixir")
    {_, response} = BicycleLock.unlock("EL!73")
    assert response == ___

    {_, response} = BicycleLock.owner_info 
    assert response == ___
  end
end