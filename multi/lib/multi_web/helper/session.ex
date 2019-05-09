defmodule CheckSessionPlug do
  use MultiWeb, :controller

  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    is_login = conn.request_path =~ "login"

    if is_login == false do
      username = get_session(conn, :username)

      if username == nil do
        redirect(conn, to: "/login")
      end
    end

    conn
  end
end
