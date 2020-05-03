defmodule GlitchTextWeb.GlitchLive do
  use GlitchTextWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(Enum.random(200..600), self(), :tick)
    end
    socket = assign_word(socket)
      {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div>Happy <%= @new_word %><div>
    """
  end

  def handle_info(:tick, socket) do
    socket = assign_word(socket)
    {:noreply, socket}
  end

  defp assign_word(socket) do
    things = ["coding","knitting","drawing","designing","planning","writing"]
    junk = "#,@,%,*,&amp;,&lt;,&gt;,_,=,+,[,],|,-,!,?,X"

    random_word = Enum.at(things,Enum.random(0..Enum.count(things)-1))

    assign(socket,
        new_word: random_word
      )
  end
end
