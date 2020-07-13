defmodule GallowsWeb.HangmanView.GameStateHelper do
  import Phoenix.HTML, only: [raw: 1]

  @responses %{
    # :initializing => {:success, "You Won!"},
    :won => {:success, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:success, "Good guess!"},
    :bad_guess => {:warning, "Bad guess!"},
    :already_used => {:info, "You already guessed that!"}
  }
  def game_state(state) do
    @responses[state]
    |> alert()
  end

  def game_over?(state), do: state in [:won, :lost]

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end
end
