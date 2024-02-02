defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    with str <-
           str
           |> String.downcase()
           |> String.replace(~r/[^a-z0-9]/, ""),
         {:ok, %{rows: _rows, columns: columns, padding: padding}} <- dimensions(str) do
      str
      |> String.graphemes()
      |> Enum.concat(List.duplicate(" ", padding))
      |> Enum.chunk_every(columns)
      |> Enum.zip()
      |> Enum.map(fn x -> Tuple.to_list(x) |> Enum.join("") end)
      |> Enum.join(" ")
    else
      _ -> ""
    end
  end

  defp dimensions(""), do: {:error, nil}

  defp dimensions(str) do
    length = String.length(str)
    columns = ceil(:math.sqrt(length))
    rows = ceil(length / columns)
    {:ok, %{rows: rows, columns: columns, padding: columns * rows - length}}
  end
end
