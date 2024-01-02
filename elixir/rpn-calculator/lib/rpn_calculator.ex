defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    case calculate_verbose(stack, operation) do
      {:error, _message} -> :error
      result -> result
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      error -> {:error, error.message}
    end
  end
end
