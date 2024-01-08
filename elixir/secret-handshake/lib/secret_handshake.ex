defmodule SecretHandshake do
  @commands [
    {8, "jump"},
    {4, "close your eyes"},
    {2, "double blink"},
    {1, "wink"},
    {16, :reverse}
  ]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(@commands, [], fn {bit, command}, acc ->
      if Bitwise.band(code, bit) > 0 do
        if command == :reverse do
          Enum.reverse(acc)
        else
          [command | acc]
        end
      else
        acc
      end
    end)
  end
end
