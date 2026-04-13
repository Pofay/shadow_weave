defmodule ShadowWeave.Plugins do
  alias ShadowWeave.Conn
  def track(%Conn{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} is on the loose!")
    conv
  end

  def track(conv), do: conv

  def log(conv), do: IO.inspect(conv)

  def rewrite_path(%Conn{path: "/wildlife"} = conv) do
    %Conn{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conn{path: "/owldbears?id=" <> id} = conv) do
    %Conn{conv | path: "/owlbears/#{id}"}
  end

  def rewrite_path(conv), do: conv

  def emojify(%Conn{status: 200} = conv) do
    %Conn{conv | resp_body: "✨ #{conv.resp_body} ✨"}
  end

  def emojify(%Conn{status: 404} = conv) do
    %Conn{conv | resp_body: "💀 #{conv.resp_body} 💀"}
  end

  def emojify(%Conn{status: 403} = conv) do
    %Conn{conv | resp_body: "⛔ #{conv.resp_body} ⛔"}
  end

  def emojify(conv), do: conv
end
