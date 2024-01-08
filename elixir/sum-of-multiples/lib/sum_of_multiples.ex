defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reduce([], fn factor, multiples ->
      get_multiples(factor, limit, factor, multiples)
    end)
    |> Enum.uniq()
    |> Enum.sum()
  end

  defp get_multiples(value, limit, factor, multiples) when value < limit and factor > 0 do
    get_multiples(value + factor, limit, factor, [value | multiples])
  end

  defp get_multiples(_value, _limit, _factor, multiples), do: multiples
end
