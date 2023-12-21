defmodule Lasagna do
  @minutes_in_oven 40
  @minutes_per_layer 2

  @doc """
  Returns the expected minutes in the oven
  """
  @spec expected_minutes_in_oven :: integer
  def expected_minutes_in_oven, do: @minutes_in_oven

  @doc """
  Calculates the remaining minutes in the oven, given the current minutes in the oven
  """
  @spec remaining_minutes_in_oven(integer) :: integer
  def remaining_minutes_in_oven(minutes_in_oven) do
    expected_minutes_in_oven() - minutes_in_oven
  end

  @doc """
  Calculates the preparation time in minutes, given the layers of lasagna
  """
  @spec preparation_time_in_minutes(integer) :: integer
  def preparation_time_in_minutes(number_of_layers) do
    number_of_layers * @minutes_per_layer
  end

  @doc """
  Calculates the total working time in minutes, given the layers of lasagna and the minutes in the oven
  """
  @spec total_time_in_minutes(integer, integer) :: integer
  def total_time_in_minutes(number_of_layers, minutes_in_oven) do
    preparation_time_in_minutes(number_of_layers) + minutes_in_oven
  end

  @doc """
  Returns an alarm message, to be used once the lasagna is ready
  """
  @spec alarm :: String.t()
  def alarm, do: "Ding!"
end
