defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn = isbn |> String.replace("-", "")

    if isbn =~ ~r/^[0-9]{9}[0-9X]$/ do
      isbn
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(0, fn {char, index}, acc ->
        if char == "X" do
          acc + 10 * (10 - index)
        else
          acc + String.to_integer(char) * (10 - index)
        end
      end)
      |> rem(11) == 0
    else
      false
    end
  end
end
