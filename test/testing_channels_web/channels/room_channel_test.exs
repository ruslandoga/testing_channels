defmodule TestingChannelsWeb.RoomChannelTest do
  use TestingChannelsWeb.ChannelCase, async: true
  alias TestingChannels.Repo

  @socket TestingChannelsWeb.UserSocket
  @pubsub TestingChannels.PubSub

  setup do
    {:ok, _, socket} =
      @socket
      |> socket("user_socket:1", %{some: :assign})
      |> subscribe_and_join(TestingChannelsWeb.RoomChannel, "room:1")

    %{socket: socket}
  end

  test "repo use after test end" do
    Phoenix.PubSub.broadcast(@pubsub, "user:1", {:event, 1 + 1})
    Repo.query!("select 1 + 1")
  end
end
