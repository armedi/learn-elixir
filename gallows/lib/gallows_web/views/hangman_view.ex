defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  import GallowsWeb.HangmanView.GameStateHelper

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def display_word(letters) do
    letters |> Enum.join(" ")
  end

  def turn(left, target) when target >= left, do: "opacity: 1"
  def turn(_left, _target), do: "opacity: 0.1"
end
