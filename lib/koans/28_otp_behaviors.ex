defmodule OTPBehaviors do
  @moduledoc false
  use Koans

  @intro "OTP Behaviors - Building robust, fault-tolerant systems"

  # Define a custom behavior
  defmodule EventHandler do
    @moduledoc "A simple behavior for handling events"

    @doc "Handle an incoming event"
    @callback handle_event(event :: any(), state :: any()) :: {:ok, any()} | {:error, any()}

    @doc "Initialize the handler"
    @callback init(args :: any()) :: {:ok, any()} | {:error, any()}
  end

  # Implement the behavior
  defmodule LoggingHandler do
    @behaviour EventHandler

    def init(log_level) do
      {:ok, %{log_level: log_level, events: []}}
    end

    def handle_event(event, state) do
      new_events = [event | state.events]
      {:ok, %{state | events: new_events}}
    end
  end

  koan "Behaviors define contracts that modules must implement" do
    {:ok, state} = LoggingHandler.init(:info)
    assert state.log_level == ___
    assert state.events == ___
  end

  koan "Behavior implementations must provide all required callbacks" do
    {:ok, state} = LoggingHandler.init(:debug)
    {:ok, new_state} = LoggingHandler.handle_event("test event", state)

    assert length(new_state.events) == ___
    assert List.first(new_state.events) == ___
  end

  # Simple Supervisor example
  defmodule SimpleSupervisor do
    use Supervisor

    def start_link(init_args) do
      Supervisor.start_link(__MODULE__, init_args, name: __MODULE__)
    end

    def init(_init_args) do
      children = [
        {SimpleWorker, %{name: "worker1"}},
        {SimpleWorker, %{name: "worker2"}}
      ]

      Supervisor.init(children, strategy: :one_for_one)
    end
  end

  defmodule SimpleWorker do
    use GenServer

    def start_link(args) do
      GenServer.start_link(__MODULE__, args)
    end

    def init(args) do
      {:ok, args}
    end

    def handle_call(:get_state, _from, state) do
      {:reply, state, state}
    end
  end

  koan "Supervisors manage child processes" do
    {:ok, supervisor_pid} = SimpleSupervisor.start_link([])
    children = Supervisor.which_children(supervisor_pid)

    assert length(children) == ___

    Supervisor.stop(supervisor_pid)
  end

  # Application behavior example
  defmodule SampleApp do
    use Application

    def start(_type, _args) do
      children = [
        {Registry, keys: :unique, name: MyRegistry},
        {DynamicSupervisor, name: MyDynamicSupervisor, strategy: :one_for_one}
      ]

      opts = [strategy: :one_for_one, name: SampleApp.Supervisor]
      Supervisor.start_link(children, opts)
    end

    def stop(_state) do
      :ok
    end
  end

  koan "Applications define how to start and stop supervision trees" do
    # We can't easily start the full application, but we can check the structure
    assert function_exported?(SampleApp, :start, 2) == ___
    assert function_exported?(SampleApp, :stop, 1) == ___
  end

  # Custom GenServer with specific behavior patterns
  defmodule Counter do
    use GenServer

    # Client API
    def start_link(initial_value \\ 0) do
      GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
    end

    def increment do
      GenServer.call(__MODULE__, :increment)
    end

    def decrement do
      GenServer.call(__MODULE__, :decrement)
    end

    def get_value do
      GenServer.call(__MODULE__, :get_value)
    end

    def reset do
      GenServer.cast(__MODULE__, :reset)
    end

    # Server callbacks
    def init(initial_value) do
      {:ok, initial_value}
    end

    def handle_call(:increment, _from, state) do
      new_state = state + 1
      {:reply, new_state, new_state}
    end

    def handle_call(:decrement, _from, state) do
      new_state = state - 1
      {:reply, new_state, new_state}
    end

    def handle_call(:get_value, _from, state) do
      {:reply, state, state}
    end

    def handle_cast(:reset, _state) do
      {:noreply, 0}
    end

    def terminate(reason, state) do
      IO.puts("Counter terminating: #{inspect(reason)}, final state: #{state}")
      :ok
    end
  end

  koan "GenServers provide structured client-server patterns" do
    {:ok, _pid} = Counter.start_link(5)

    assert Counter.get_value() == ___
    assert Counter.increment() == ___
    assert Counter.increment() == ___
    assert Counter.decrement() == ___

    Counter.reset()
    assert Counter.get_value() == ___

    GenServer.stop(Counter)
  end

  # Task Supervisor for managing dynamic tasks
  defmodule TaskManager do
    use DynamicSupervisor

    def start_link(_args) do
      DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    end

    def init(:ok) do
      DynamicSupervisor.init(strategy: :one_for_one)
    end

    def start_task(fun) do
      spec = Task.child_spec(fun)
      DynamicSupervisor.start_child(__MODULE__, spec)
    end

    def list_tasks do
      DynamicSupervisor.which_children(__MODULE__)
    end
  end

  koan "DynamicSupervisor manages children that are started and stopped dynamically" do
    {:ok, _pid} = TaskManager.start_link([])

    # Start a task
    {:ok, task_pid} =
      TaskManager.start_task(fn ->
        Process.sleep(1000)
        :completed
      end)

    tasks = TaskManager.list_tasks()
    assert length(tasks) == ___

    # Task should be running
    assert Process.alive?(task_pid) == ___

    DynamicSupervisor.stop(TaskManager)
  end

  # Registry for process discovery
  defmodule ServiceRegistry do
    def start_link do
      Registry.start_link(keys: :unique, name: __MODULE__)
    end

    def register_service(name, pid) do
      Registry.register(__MODULE__, name, pid)
    end

    def find_service(name) do
      case Registry.lookup(__MODULE__, name) do
        [{pid, _}] -> {:ok, pid}
        [] -> {:error, :not_found}
      end
    end

    def list_services do
      Registry.select(__MODULE__, [{{:"$1", :"$2", :"$3"}, [], [{{:"$1", :"$2"}}]}])
    end
  end

  koan "Registry provides service discovery for processes" do
    {:ok, _registry_pid} = ServiceRegistry.start_link()
    {:ok, worker_pid} = SimpleWorker.start_link(%{name: "test_service"})

    # Register the service
    {:ok, _} = ServiceRegistry.register_service(:test_service, worker_pid)

    # Find the service
    {:ok, found_pid} = ServiceRegistry.find_service(:test_service)
    assert found_pid == ___

    # List all services
    services = ServiceRegistry.list_services()
    assert length(services) == ___

    GenServer.stop(worker_pid)
    Registry.stop(ServiceRegistry)
  end

  # Custom behavior with optional callbacks
  defmodule Worker do
    @doc "Define the behavior for worker modules"

    @callback start_work(args :: any()) :: {:ok, any()} | {:error, any()}
    @callback stop_work(state :: any()) :: :ok

    @optional_callbacks stop_work: 1

    defmacro __using__(_opts) do
      quote do
        @behaviour Worker

        # Provide default implementation for optional callback
        def stop_work(_state), do: :ok

        defoverridable stop_work: 1
      end
    end
  end

  defmodule DatabaseWorker do
    use Worker

    def start_work(config) do
      {:ok, %{connected: true, config: config}}
    end

    # Override the default implementation
    def stop_work(state) do
      IO.puts("Closing database connection")
      :ok
    end
  end

  defmodule SimpleWorkerImpl do
    use Worker

    def start_work(args) do
      {:ok, %{status: :working, args: args}}
    end

    # Uses default stop_work implementation
  end

  koan "Behaviors can have optional callbacks with default implementations" do
    {:ok, db_state} = DatabaseWorker.start_work(%{host: "localhost"})
    assert db_state.connected == ___

    {:ok, simple_state} = SimpleWorkerImpl.start_work("test")
    assert simple_state.status == ___

    # Both should implement stop_work
    assert DatabaseWorker.stop_work(db_state) == ___
    assert SimpleWorkerImpl.stop_work(simple_state) == ___
  end

  # Supervision strategies demonstration
  defmodule RestartStrategies do
    def demonstrate_one_for_one do
      # In :one_for_one, only the failed child is restarted
      children = [
        {SimpleWorker, %{name: "worker1"}},
        {SimpleWorker, %{name: "worker2"}},
        {SimpleWorker, %{name: "worker3"}}
      ]

      {:ok, supervisor} = Supervisor.start_link(children, strategy: :one_for_one)
      initial_count = length(Supervisor.which_children(supervisor))

      Supervisor.stop(supervisor)
      initial_count
    end

    def demonstrate_one_for_all do
      # In :one_for_all, if one child dies, all children are restarted
      children = [
        {SimpleWorker, %{name: "worker1"}},
        {SimpleWorker, %{name: "worker2"}}
      ]

      {:ok, supervisor} = Supervisor.start_link(children, strategy: :one_for_all)
      initial_count = length(Supervisor.which_children(supervisor))

      Supervisor.stop(supervisor)
      initial_count
    end
  end

  koan "Different supervision strategies handle failures differently" do
    one_for_one_count = RestartStrategies.demonstrate_one_for_one()
    assert one_for_one_count == ___

    one_for_all_count = RestartStrategies.demonstrate_one_for_all()
    assert one_for_all_count == ___
  end

  koan "OTP provides building blocks for fault-tolerant systems" do
    # The key principles of OTP
    principles = [
      :let_it_crash,
      :supervision_trees,
      :isolation,
      :restart_strategies
    ]

    assert :let_it_crash in principles == ___
    assert length(principles) == ___
  end
end
