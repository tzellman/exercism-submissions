defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9']/, " ")
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&trim_quotes/1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.reduce(%{}, &count_word/2)
  end

  defp count_word(word, acc) do
    Map.update(acc, word, 1, &(&1 + 1))
  end

  defp trim_quotes(word) do
    word |> String.replace(~r/^'(.*)'$/, "\\1") |> String.replace(~r/^"(.*)"$/, "\\1")
  end
end
