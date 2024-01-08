defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    with :ok <- validate(a, b, c) do
      case [a, b, c] |> Enum.uniq() |> length() do
        1 -> {:ok, :equilateral}
        2 -> {:ok, :isosceles}
        3 -> {:ok, :scalene}
      end
    end
  end

  defp validate(a, b, c) when a > 0 and b > 0 and c > 0 do
    if a + b >= c and a + c >= b and b + c >= a do
      :ok
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end

  defp validate(_, _, _), do: {:error, "all side lengths must be positive"}
end
