defmodule TestingChannelsWeb.RoomChannel do
  use TestingChannelsWeb, :channel

  @impl true
  def join("room:" <> id, _payload, socket) do
    Phoenix.PubSub.subscribe(TestingChannels.PubSub, "user:" <> id)
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
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
