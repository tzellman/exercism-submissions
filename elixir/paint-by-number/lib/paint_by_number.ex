defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    :math.log2(color_count) |> ceil()
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(color_count |> palette_bit_size), picture::bitstring>>
  end

  def get_first_pixel("" = _picture, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    bits = color_count |> palette_bit_size()
    <<pixel_color_index::size(bits), _rest::bitstring>> = picture
    pixel_color_index
  end

  def drop_first_pixel("" = _picture, _color_count), do: empty_picture()

  def drop_first_pixel(picture, color_count) do
    bits = color_count |> palette_bit_size()
    <<_first_pixel::size(bits), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
