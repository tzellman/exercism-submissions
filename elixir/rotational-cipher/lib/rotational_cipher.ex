defmodule RotationalCipher do
  @cipher_size 26

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text) |> Enum.map(&rotate_char(&1, shift, nil)) |> List.to_string()
  end

  defp rotate_char(char, shift, nil) do
    cond do
      char >= ?a and char <= ?z -> rotate_char(char, shift, ?a)
      char >= ?A and char <= ?Z -> rotate_char(char, shift, ?A)
      true -> char
    end
  end

  defp rotate_char(char, shift, start) do
    rem(char - start + shift, @cipher_size) + start
  end
end
