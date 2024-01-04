defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      word =~ ~r/^[aeiou]/i -> translate_vowel(word)
      word =~ ~r/^[^aeiou]+/i -> translate_consonant(word)
      true -> word
    end
  end

  defp translate_vowel(word) do
    word <> "ay"
  end

  defp translate_consonant(word) do
    translations = [
      {~r/^([xy][^aeiou])(.*)/i, "\\1\\2ay"},
      {~r/^([^aeiou]+)(y.*)/i, "\\2\\1ay"},
      {~r/^([^aeiou]*qu)(.*)/i, "\\2\\1ay"},
      {~r/^([^aeiou]+)(.*)/i, "\\2\\1ay"}
    ]

    Enum.reduce_while(translations, word, fn {pattern, replacement}, word ->
      if word =~ pattern do
        {:halt, String.replace(word, pattern, replacement)}
      else
        {:cont, word}
      end
    end)
  end
end
