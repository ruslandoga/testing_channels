defmodule TestingChannelsWeb.RoomChannelTest do
  use TestingChannelsWeb.ChannelCase, async: true
  alias TestingChannels.Repo

  @socket TestingChannelsWeb.UserSocket
  @pubsub TestingChannels.PubSub

  setup do
    {:ok, _, socket} =
      @socket
      |> socket("user:1", %{some: :assign})
      |> subscribe_and_join(TestingChannelsWeb.RoomChannel, "room:1")

    {:ok, _, other_socket} =
      @socket
      |> socket("user:2", %{some: :assign})
      |> subscribe_and_join(TestingChannelsWeb.RoomChannel, "room:2")

    %{socket: socket, other_socket: other_socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end

  test "repo use after test end" do
    Phoenix.PubSub.broadcast(@pubsub, "user:2", {:event, 1 + 1})
    Repo.query!("select 1 + 1")
  end
end
