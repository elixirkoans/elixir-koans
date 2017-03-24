defmodule GenServers do
  use Koans

  @intro "GenServers"

  defmodule ExampleGenServer do
    use GenServer

    # Use init to set up initial state []
    def init(_args) do
      {:ok, []}
    end

    # Use calls to perform synchronous actions
    def handle_call(:pop, _from, [head|tail]) do
      {:reply, head, tail}
    end

    def handle_call(:peek, _from, stack) do
      {:reply, stack, stack}
    end

    # Use casts to perform asynchronous actions
    def handle_cast({:push, value}, stack) do
      {:noreply, [value|stack]}
    end
  end


  koan "You can think of GenServers like more flexible agents" do
    {:ok, pid} = GenServer.start_link(ExampleGenServer, :ok, [])

    assert is_pid(pid) == ___
  end

  koan "GenServers can have a name too" do
    {:ok, pid} = GenServer.start_link(ExampleGenServer, :ok, name: StackServer)

    assert is_pid(GenServer.whereis(StackServer)) == ___
  end

  koan "Use call to send a synchronous request to the server" do
    GenServer.start_link(ExampleGenServer, :ok, name: StackServer)

    stack = GenServer.call(StackServer, :peek)

    assert stack == ___
  end

  koan "Use cast to send an asynchronous request to the server" do
    GenServer.start_link(ExampleGenServer, :ok, name: StackServer)

    GenServer.cast(StackServer, {:push, 1})
    GenServer.cast(StackServer, {:push, 3})
    GenServer.cast(StackServer, {:push, 5})

    :timer.sleep(10)
    stack = GenServer.call(StackServer, :peek)

    assert stack == ___
  end

  koan "Casts always return :ok, they can't be trusted" do
    response = GenServer.cast(NonexistentServer, :do_stuff)

    assert response == ___
  end
end
