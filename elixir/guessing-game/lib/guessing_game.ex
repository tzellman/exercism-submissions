defmodule GuessingGame do
  def compare(_secret_number, _ \\ :no_guess)

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and guess == secret_number do
    "Correct"
  end

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and abs(secret_number - guess) == 1 do
    "So close"
  end

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and guess > secret_number do
    "Too high"
  end

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and guess < secret_number do
    "Too low"
  end

  def compare(_secret_number, _guess), do: "Make a guess"
end
