defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    transform(number, "")
  end

  defp transform(0, acc), do: acc

  defp transform(number, acc) do
    cond do
      number >= 1000 -> transform(number - 1000, acc <> "M")
      number >= 900 -> transform(number - 900, acc <> "CM")
      number >= 500 -> transform(number - 500, acc <> "D")
      number >= 400 -> transform(number - 400, acc <> "CD")
      number >= 100 -> transform(number - 100, acc <> "C")
      number >= 90 -> transform(number - 90, acc <> "XC")
      number >= 50 -> transform(number - 50, acc <> "L")
      number >= 40 -> transform(number - 40, acc <> "XL")
      number >= 10 -> transform(number - 10, acc <> "X")
      number >= 9 -> transform(number - 9, acc <> "IX")
      number >= 5 -> transform(number - 5, acc <> "V")
      number >= 4 -> transform(number - 4, acc <> "IV")
      number >= 1 -> transform(number - 1, acc <> "I")
    end
  end
end
