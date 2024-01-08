defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_while(
      {nil, 0},
      fn x, {y, count} ->
        if y == x or is_nil(y) do
          {:cont, {x, count + 1}}
        else
          {:cont, {y, count}, {x, 1}}
        end
      end,
      fn
        {nil, 0} -> {:cont, nil}
        {x, count} -> {:cont, {x, count}, nil}
      end
    )
    |> Enum.map(fn {x, count} ->
      if count == 1 do
        x
      else
        "#{count}#{x}"
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.graphemes()
    |> Enum.reduce({"", ""}, fn x, {y, result} ->
      if String.match?(x, ~r/\d/) do
        {y <> x, result}
      else
        if String.match?(y, ~r/\d+/) do
          {"", result <> String.duplicate(x, y |> String.to_integer())}
        else
          {"", result <> x}
        end
      end
    end)
    |> elem(1)
  end
end
