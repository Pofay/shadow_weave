defmodule ShadowWeave.Alternative.HttpServer do
  use ThousandIsland.Handler

  alias ShadowWeave.Handler

  def start(port) when is_integer(port) and port > 1023 do
    IO.puts("\n🎧  Listening for connection requests on port #{port}...\n")

    ThousandIsland.start_link(
      port: port,
      handler_module: __MODULE__
    )
  end

  @impl ThousandIsland.Handler
  def handle_connection(_socket, state) do
    IO.puts("⚡️  Connection accepted!\n")
    {:continue, state}
  end

  @impl ThousandIsland.Handler
  def handle_data(request, socket, state) do
    IO.puts("➡️  Received request:\n")
    IO.puts(request)

    response = Handler.handle_request(request)

    ThousandIsland.Socket.send(socket, response)

    IO.puts("⬅️  Sent response:\n")
    IO.puts(response)

    # Closes this client only. The listening socket stays open.
    {:close, state}
  end


end
