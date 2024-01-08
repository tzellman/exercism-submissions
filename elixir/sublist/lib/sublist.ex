defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) when length(a) < length(b) do
    with sub_length <- length(a),
         checks <- length(b) - length(a) do
      case Enum.any?(0..checks, fn i ->
             compare(a, Enum.slice(b, i, sub_length)) == :equal
           end) do
        true -> :sublist
        false -> :unequal
      end
    end
  end

  def compare(a, b) when length(a) > length(b) do
    compare(b, a) |> get_opposite()
  end

  def compare(_a, _b), do: :unequal

  defp get_opposite(:sublist), do: :superlist
  defp get_opposite(:superlist), do: :sublist
  defp get_opposite(:unequal), do: :unequal
end
