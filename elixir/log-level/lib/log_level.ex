defmodule LogLevel do
  @spec to_label(integer(), boolean()) ::
          :trace | :debug | :info | :warning | :error | :fatal | :unknown
  def to_label(level, _legacy? = false), do: get_label(level)

  def to_label(level, _legacy? = true) do
    cond do
      level > 0 && level < 5 -> get_label(level)
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    case to_label(level, legacy?) do
      l when l in [:error, :fatal] ->
        :ops

      :unknown ->
        if legacy?, do: :dev1, else: :dev2

      _ ->
        false
    end
  end

  defp get_label(0), do: :trace
  defp get_label(1), do: :debug
  defp get_label(2), do: :info
  defp get_label(3), do: :warning
  defp get_label(4), do: :error
  defp get_label(5), do: :fatal
  defp get_label(_), do: :unknown
end
