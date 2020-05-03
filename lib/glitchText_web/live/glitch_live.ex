defmodule GlitchTextWeb.GlitchLive do
  use GlitchTextWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(Enum.random(100..500), self(), :tick)
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
    things = ["coding","knitting","drawing","designing","planning","writing","concluding","programming","thinking","painting"]
    junk = ["#","@","%","*","&amp;","&lt;","&gt;","_","=","+","[","]","|","-","!","?","X"]

    random_word = Enum.at(things,Enum.random(0..Enum.count(things)-1))
    pattern = String.slice(random_word,Enum.random(0..String.length(random_word)-1),1)
    replace_by = Enum.at(junk,Enum.random(0..Enum.count(junk)-1))
    assign(socket,
        new_word: String.replace(random_word, pattern, replace_by, global: false)
      )
  end
end
