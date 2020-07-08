defmodule GameTest do
  use ExUnit.Case
  doctest Hangman
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters > 0
    Enum.all?(game.letters, &(&1 == ~r/[a-z]/))
  end

  test "state is changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game =
      Game.new_game()
      |> Game.make_move("x")

    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game =
      Game.new_game()
      |> Game.make_move("x")
      |> Game.make_move("x")

    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game =
      Game.new_game("wibble")
      |> Game.make_move("w")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game =
      Game.new_game("wibble")
      |> Game.make_move("i")
      |> Game.make_move("w")
      |> Game.make_move("e")
      |> Game.make_move("b")
      |> Game.make_move("l")

    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game =
      Game.new_game("wibble")
      |> Game.make_move("v")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6

    game = Game.make_move(game, "n")

    assert game.game_state == :bad_guess
    assert game.turns_left == 5
  end

  test "lost game is recognized" do
    game =
      Game.new_game("wibble")
      |> Game.make_move("v")
      |> Game.make_move("n")
      |> Game.make_move("f")
      |> Game.make_move("h")
      |> Game.make_move("y")
      |> Game.make_move("o")
      |> Game.make_move("p")

    assert game.game_state == :lost
  end
end
