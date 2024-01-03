defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, fn digit -> digit < 0 or digit >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        {:ok, convert_to_base(digits, input_base, output_base)}
    end
  end

  defp convert_to_base([], _input_base, _output_base), do: [0]

  defp convert_to_base(digits, input_base, output_base) do
    digits
    |> convert_to_decimal(input_base)
    |> convert_from_decimal(output_base, [])
  end

  defp convert_to_decimal(digits, base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, acc ->
      acc + digit * :math.pow(base, index)
    end)
    |> round()
  end

  defp convert_from_decimal(number, base, acc) do
    cond do
      number == 0 and acc == [] ->
        [0]

      number == 0 ->
        acc

      true ->
        div = div(number, base)
        rem = rem(number, base)
        convert_from_decimal(div, base, [rem | acc])
    end
  end
end
