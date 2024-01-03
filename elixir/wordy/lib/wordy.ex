defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    with parts <-
           question
           |> String.replace("What is ", "")
           |> String.replace_suffix("?", "")
           |> String.split(" ") do
      do_answer(parts)
    end
  end

  defp do_answer([value]), do: normalize(value)

  defp do_answer([left, "plus", right | rest]) do
    with [left, right] <- [left, right] |> Enum.map(&normalize/1) do
      do_answer([left + right | rest])
    end
  end

  defp do_answer([left, "minus", right | rest]) do
    with [left, right] <- [left, right] |> Enum.map(&normalize/1) do
      do_answer([left - right | rest])
    end
  end

  defp do_answer([left, "multiplied", "by", right | rest]) do
    with [left, right] <- [left, right] |> Enum.map(&normalize/1) do
      do_answer([left * right | rest])
    end
  end

  defp do_answer([left, "divided", "by", right | rest]) do
    with [left, right] <- [left, right] |> Enum.map(&normalize/1) do
      do_answer([left / right | rest])
    end
  end

  defp do_answer(_), do: raise(ArgumentError)

  defp normalize(value) when is_binary(value), do: String.to_integer(value)
  defp normalize(value), do: value
end
