defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]
  @empty_histogram @nucleotides |> Enum.map(fn n -> {n, 0} end) |> Enum.into(%{})

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    histogram(strand)[nucleotide]
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Enum.reduce(strand, @empty_histogram, fn char, map ->
      Map.update!(map, char, &(&1 + 1))
    end)
  end
end
