defmodule FreelancerRates do
  @day_hours 8.0
  @billable_days 22.0

  def daily_rate(hourly_rate), do: hourly_rate * @day_hours

  def apply_discount(before_discount, discount), do: before_discount * (100 - discount) / 100

  def monthly_rate(hourly_rate, discount) do
    (daily_rate(hourly_rate) * @billable_days) |> apply_discount(discount) |> ceil() |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget / (daily_rate(hourly_rate) |> apply_discount(discount))) |> Float.floor(1)
  end
end
