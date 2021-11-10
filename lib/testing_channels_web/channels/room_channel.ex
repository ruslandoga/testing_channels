defmodule TestingChannelsWeb.RoomChannel do
  use TestingChannelsWeb, :channel

  @impl true
  def join("room:" <> id, _payload, socket) do
    Phoenix.PubSub.subscribe(TestingChannels.PubSub, "user:" <> id)
    {:ok, socket}
  end

  @impl true
  def handle_info({:event, number}, socket) do
    if number == touch_repo() do
      push(socket, "event", %{"event" => number})
    end

    {:noreply, socket}
  end

  def touch_repo do
    TestingChannels.Repo.query!("select 1 + 1").rows[0][0]
  end
end
