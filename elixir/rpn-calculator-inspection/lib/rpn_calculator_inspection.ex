defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    with {:ok, pid} <- Task.start_link(fn -> calculator.(input) end) do
      %{input: input, pid: pid}
    end
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    original_flag = Process.flag(:trap_exit, true)

    procs =
      Enum.map(inputs, fn input ->
        start_reliability_check(calculator, input)
      end)

    results =
      Enum.reduce(procs, %{}, fn proc, results ->
        await_reliability_check_result(proc, results)
      end)

    Process.flag(:trap_exit, original_flag)
    results
  end

  def correctness_check(calculator, inputs) do
    procs =
      Enum.map(inputs, fn input ->
        Task.async(fn -> calculator.(input) end)
      end)

    Enum.map(procs, fn proc ->
      Task.await(proc, 100)
    end)
  end
end
