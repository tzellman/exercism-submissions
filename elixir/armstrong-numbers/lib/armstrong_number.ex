defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    with digits <- Integer.digits(number),
         num_digits <- length(digits),
         powers <- Enum.map(digits, fn digit -> Integer.pow(digit, num_digits) end),
         sum <- Enum.sum(powers) do
      sum == number
    end
  end
end
