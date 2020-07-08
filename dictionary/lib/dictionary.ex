defmodule Dictionary do
  @spec random_word :: binary
  def random_word do
    words_list()
    |> Enum.random()
  end

  @spec words_list :: [binary]
  def words_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
