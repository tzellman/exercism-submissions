defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    with graphemes <- String.graphemes(s),
         chunks <- get_chunks(graphemes |> length(), size) do
      case chunks do
        0 ->
          []

        _ ->
          for i <- 0..(chunks - 1), do: graphemes |> Enum.slice(i, size) |> Enum.join()
      end
    end
  end

  defp get_chunks(length, size) when length > size and size > 0, do: length - size + 1
  defp get_chunks(length, length) when length > 0, do: 1
  defp get_chunks(_, _), do: 0
end
