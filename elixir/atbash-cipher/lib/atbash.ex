defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> transform_to_chars()
    |> Enum.chunk_every(5)
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> transform_to_chars()
    |> to_string()
  end

  defp encode_char(char) do
    cond do
      char >= ?a and char <= ?z ->
        ?a + ?z - char

      char >= ?0 and char <= ?9 ->
        char

      true ->
        ?\s
    end
  end

  defp transform_to_chars(plaintext) do
    plaintext
    |> String.downcase()
    |> to_charlist()
    |> Enum.map(&encode_char/1)
    |> Enum.reject(&(&1 == ?\s))
  end
end
