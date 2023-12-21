defmodule BirdCount do
  @busy_day_birds 5

  def today([]), do: nil
  def today([today | _rest]), do: today

  def increment_day_count([today | rest]) do
    [today + 1 | rest]
  end

  def increment_day_count([]), do: [1]

  def has_day_without_birds?(list), do: 0 in list

  def total([head | tail]), do: head + total(tail)
  def total([]), do: 0

  def busy_days([head | tail]) do
    if head >= @busy_day_birds do
      1 + busy_days(tail)
    else
      busy_days(tail)
    end
  end

  def busy_days([]), do: 0
end
