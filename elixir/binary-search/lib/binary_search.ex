defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    numbers |> Tuple.to_list() |> Enum.sort() |> do_search(key, 0)
  end

  defp do_search([], _key, _index), do: :not_found
  defp do_search([number], number, index), do: {:ok, index}
  defp do_search([_number], _key, _index), do: :not_found

  defp do_search(numbers, key, index) do
    middle = length(numbers) |> div(2)

    case Enum.at(numbers, middle) do
      number when number == key ->
        {:ok, index + middle}

      number when number > key ->
        do_search(Enum.slice(numbers, 0, middle), key, index)

      _number ->
        do_search(Enum.slice(numbers, middle + 1, length(numbers)), key, index + middle + 1)
    end
  end
end
