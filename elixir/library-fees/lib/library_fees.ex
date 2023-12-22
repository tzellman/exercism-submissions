defmodule LibraryFees do
  @checkout_days 28

  def datetime_from_string(string) do
    with {:ok, datetime} <- NaiveDateTime.from_iso8601(string) do
      datetime
    else
      _ -> {:error, "Invalid datetime"}
    end
  end

  def before_noon?(naive_datetime) do
    naive_datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_add = @checkout_days + if(checkout_datetime |> before_noon?(), do: 0, else: 1)
    checkout_datetime |> NaiveDateTime.add(days_to_add, :day) |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = actual_return_datetime |> NaiveDateTime.to_date()
    diff = Date.diff(actual_return_date, planned_return_date)

    cond do
      diff < 0 -> 0
      diff == 0 -> 0
      diff > 0 -> diff
    end
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    with checkout <- checkout |> datetime_from_string(),
         return <- return |> datetime_from_string(),
         return_date <- checkout |> return_date(),
         days_late <- return_date |> days_late(return),
         monday? <- return |> monday?(),
         adjusted_pct <- if(monday?, do: 0.5, else: 1.0) do
      (days_late * rate * adjusted_pct) |> floor()
    end
  end
end
