defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n > 0 do
    Stream.unfold({1, []}, &next_prime/1) |> Enum.at(n - 1)
  end

  defp next_prime({1, []}), do: {2, {2, [2]}}

  defp next_prime({n, primes}) do
    next_n = n + 1

    case prime?(next_n, primes) do
      true ->
        {next_n, {next_n, [next_n | primes]}}

      false ->
        next_prime({next_n, primes})
    end
  end

  defp prime?(n, primes) do
    case rem(n, 2) do
      0 ->
        false

      _ ->
        Enum.all?(primes, fn p -> rem(n, p) != 0 end)
    end
  end
end
