defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    with sentence <- String.replace(sentence, ~r/[- ]/, ""),
         unique_letters <- sentence |> String.downcase() |> String.graphemes() |> Enum.uniq() do
      length(unique_letters) == String.length(sentence)
    end
  end
end
