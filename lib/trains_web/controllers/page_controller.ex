defmodule TrainsWeb.PageController do
  use TrainsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
