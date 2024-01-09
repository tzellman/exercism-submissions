defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    with input <- input |> String.trim(),
         is_question <- question?(input),
         is_yelling <- yelling?(input),
         is_silent <- silent?(input) do
      cond do
        is_silent -> "Fine. Be that way!"
        is_question and is_yelling -> "Calm down, I know what I'm doing!"
        is_question -> "Sure."
        is_yelling -> "Whoa, chill out!"
        true -> "Whatever."
      end
    end
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp yelling?(input) do
    with upcase <- String.upcase(input),
         gibberish <- String.downcase(input) == upcase do
      upcase == input and not gibberish
    end
  end

  defp silent?(input) do
    input == ""
  end
end
