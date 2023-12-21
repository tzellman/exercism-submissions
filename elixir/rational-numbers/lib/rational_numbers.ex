defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    {a1 * b2 + a2 * b1, b1 * b2} |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    {a1 * b2 - a2 * b1, b1 * b2} |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    {a1 * a2, b1 * b2} |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    {a1 * b2, a2 * b1} |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a1, b1}) do
    {abs_value(a1), abs_value(b1)} |> reduce()
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0 do
    pow_rational({b, a}, -n)
  end

  def pow_rational({a, b}, n) do
    {:math.pow(a, n), :math.pow(b, n)} |> reduce()
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, number) do
    {a, b} = number |> reduce()
    :math.pow(x, a) |> nth_root(b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _b}), do: {0, 1}

  def reduce({a, b}) do
    with a <- trunc(a),
         b <- trunc(b),
         gcd <- Integer.gcd(a, b),
         a <- div(a, gcd),
         b <- div(b, gcd) do
      {a, b} |> standard_form()
    end
  end

  defp standard_form({a, b}) when b < 0, do: standard_form({-a, -b})
  defp standard_form({a, b}), do: {a, b}

  defp abs_value(a) when a < 0, do: -a
  defp abs_value(a), do: a

  defp nth_root(number, 1), do: number
  defp nth_root(number, 2), do: :math.sqrt(number)
  defp nth_root(number, root), do: :math.pow(number, 1 / root)
end
