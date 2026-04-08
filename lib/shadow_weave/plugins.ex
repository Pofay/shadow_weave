defmodule ShadowWeave.Plugins do
  def track(%{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} is on the loose!")
    conv
  end

  def track(conv), do: conv

  def log(conv), do: IO.inspect(conv)

  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%{path: "/owldbears?id=" <> id} = conv) do
    %{conv | path: "/owlbears/#{id}"}
  end

  def rewrite_path(conv), do: conv

  def emojify(%{status: 200} = conv) do
    %{conv | resp_body: "✨ #{conv.resp_body} ✨"}
  end

  def emojify(%{status: 404} = conv) do
    %{conv | resp_body: "💀 #{conv.resp_body} 💀"}
  end

  def emojify(%{status: 403} = conv) do
    %{conv | resp_body: "⛔ #{conv.resp_body} ⛔"}
  end

  def emojify(conv), do: conv
end
