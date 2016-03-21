defmodule Tasks do
  use Koans

  koan "Tasks can be used for asynchronous computations with results" do
    task = Task.async(fn -> 3 *3 end)
    do_other_stuff()
    assert Task.await(task) + 1 == :__
  end

  koan "If you don't need a result, use start_link/1" do
    {result, _pid} = Task.start_link(fn -> 1+1 end)
    assert result == :__
  end

  koan "Yield returns nothing if the task isn't done yet" do
    handle = Task.async(fn ->
                             :timer.sleep(100)
                             3 * 3
                         end)
    assert Task.yield(handle, 10) == :__
  end

  koan "Tasks can be aborted with shutdown" do
    handle = Task.async(fn ->
                             :timer.sleep(100)
                             3 * 3
                         end)
    assert Task.shutdown(handle) == :__
  end

  koan "shutdown will give you an answer if it has it" do
    handle = Task.async(fn -> 3 * 3 end)
    :timer.sleep(10)
    assert Task.shutdown(handle) == {:ok, :__}
  end

  koan "You can yield to multiple tasks at once and extract the results" do
   squares = [1,2,3,4]
             |> Enum.map(fn(number) -> Task.async(fn -> number * number end) end)
             |> Task.yield_many(100)
             |> Enum.map(fn({_task,{:ok, result}}) -> result end)

  assert squares == :__
  end

  def do_other_stuff do
    :timer.sleep(50)
  end
end
