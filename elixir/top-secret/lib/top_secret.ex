defmodule TopSecret do
  def to_ast(string) do
    with {:ok, quoted} <- string |> Code.string_to_quoted() do
      quoted
    end
  end

  def decode_secret_message_part(ast, acc) do
    {ast, maybe_decode(ast, acc, nil)}
  end

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalker()
    |> Enum.reduce([], fn ast, acc ->
      case ast do
        {op, _, _} when op in [:def, :defp] ->
          {_, acc} = decode_secret_message_part(ast, acc)
          acc

        _ ->
          acc
      end
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp maybe_decode({op, _info, [first_child | _rest]}, acc, parent)
       when op in [:def, :defp] and is_nil(parent) do
    maybe_decode(first_child, acc, op)
  end

  defp maybe_decode({:when = op, _info, [first_child | _rest]}, acc, parent)
       when not is_nil(parent) do
    maybe_decode(first_child, acc, op)
  end

  defp maybe_decode({op, _info, params}, acc, parent)
       when not is_nil(parent) do
    [decoded_function_name(op, params) | acc]
  end

  defp maybe_decode(_, acc, nil), do: acc

  defp decoded_function_name(_atom, nil), do: ""

  defp decoded_function_name(atom, params),
    do: atom |> Atom.to_string() |> String.slice(0, params |> length())
end
