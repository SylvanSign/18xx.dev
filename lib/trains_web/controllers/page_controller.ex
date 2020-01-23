defmodule TrainsWeb.PageController do
  use TrainsWeb, :controller

  @dimension 500

  def index(conn, _params) do
    render(conn, "index.html",
      game: "1889",
      height: @dimension,
      width: @dimension,
      viewBox: "-87.6025 -76 175.205 152"
    )
  end
end
