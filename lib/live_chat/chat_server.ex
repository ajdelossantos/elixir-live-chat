defmodule LiveChat.ChatServer do
  use GenServer

  def init(_opts) do
    state = %{
      messages: []
    }

    {:ok, state}
  end

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  def get_messages, do: GenServer.call(__MODULE__, :get_messages)

  def new_messages(user, message), do: GenServer.cast(__MODULE__, {:new_message, user, message})

  def handle_call(:get_messages, _from, %{messages: messages} = state), do: {:reply, messages, state}

  def handle_cast({:new_message, user, message}, %{messages: messages} = state) do
    messages = messages ++ [%{user: user, message: message}]
    Phoenix.PubSub.broadcast(LiveChat.PubSub, "lobby", {:messages, messages})
    {:noreply, %{state | messages: messages}}
  end

end
