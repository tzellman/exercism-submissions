defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale

  Recent updates:
  - separate format_header to a match clause
  - separate format_amount to separate function
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @eur_currency "€"
  @usd_currency "$"

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_currency, locale, []) do
    format_header(locale)
  end

  def format_entries(currency, locale, entries) do
    entries =
      Enum.sort(entries, &compare_entries/2)
      |> Enum.map(&format_entry(currency, locale, &1))
      |> Enum.join("\n")

    format_header(locale) <> entries <> "\n"
  end

  defp format_header(:en_US), do: "Date       | Description               | Change       \n"
  defp format_header(:nl_NL), do: "Datum      | Omschrijving              | Verandering  \n"

  defp format_entry(currency, locale, entry) do
    date = locale |> format_date(entry.date)
    amount = format_amount(entry.amount_in_cents, locale, currency) |> String.pad_leading(14, " ")
    description = format_description(entry.description)
    date <> "|" <> description <> " |" <> amount
  end

  defp format_date(locale, date) do
    year = date.year |> to_string()
    month = date.month |> to_string() |> String.pad_leading(2, "0")
    day = date.day |> to_string() |> String.pad_leading(2, "0")
    locale |> construct_date(year, month, day)
  end

  defp construct_date(:en_US, year, month, day), do: month <> "/" <> day <> "/" <> year <> " "
  defp construct_date(:nl_NL, year, month, day), do: day <> "-" <> month <> "-" <> year <> " "

  defp format_amount(amount_in_cents, locale, currency) when amount_in_cents < 0 do
    amount_in_cents |> format_money(locale) |> format_amount_loss(locale, currency)
  end

  defp format_amount(amount_in_cents, locale, currency) do
    amount_in_cents |> format_money(locale) |> format_amount_gain(locale, currency)
  end

  defp format_amount_loss(amount, :en_US, currency),
    do: " (#{currency_symbol(currency)}#{amount})"

  defp format_amount_loss(amount, :nl_NL, currency),
    do: " #{currency_symbol(currency)} -#{amount} "

  defp format_amount_gain(amount, :en_US, currency),
    do: "  #{currency_symbol(currency)}#{amount} "

  defp format_amount_gain(amount, :nl_NL, currency),
    do: " #{currency_symbol(currency)} #{amount} "

  defp currency_symbol(:usd), do: @usd_currency
  defp currency_symbol(:eur), do: @eur_currency

  defp format_money(amount_in_cents, :en_US), do: format_money(amount_in_cents, ",", ".")
  defp format_money(amount_in_cents, :nl_NL), do: format_money(amount_in_cents, ".", ",")

  defp format_money(amount_in_cents, thousand_separator, cents_separator) do
    decimal =
      amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")

    whole =
      if abs(div(amount_in_cents, 100)) < 1000 do
        abs(div(amount_in_cents, 100)) |> to_string()
      else
        to_string(div(abs(div(amount_in_cents, 100)), 1000)) <>
          thousand_separator <> to_string(rem(abs(div(amount_in_cents, 100)), 1000))
      end

    whole <> cents_separator <> decimal
  end

  defp format_description(description) do
    if description |> String.length() > 26 do
      " " <> String.slice(description, 0, 22) <> "..."
    else
      " " <> String.pad_trailing(description, 25, " ")
    end
  end

  defp compare_entries(a, b) do
    cond do
      a.date.day < b.date.day -> true
      a.date.day > b.date.day -> false
      a.description < b.description -> true
      a.description > b.description -> false
      true -> a.amount_in_cents <= b.amount_in_cents
    end
  end
end
