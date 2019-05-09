defmodule CheckSessionPlug do
  use SingleWeb, :controller

  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    is_login = conn.request_path =~ "login" || conn.request_path =~ "api"

    guid = conn.req_cookies["guid"]

    if guid == nil do
      date = :os.system_time(:second)
      hash = Base.encode16(:crypto.hash(:md5, Integer.to_string(date)), case: :lower)

      conn |> put_resp_cookie("guid", "guid-#{hash}") |> redirect(to: "/login")
    else
      usernames = :ets.lookup(:web_session, guid)

      case length(usernames) do
        1 ->
          [value] = usernames

          {guid, username} = value

          guids = :ets.lookup(:web_session, username)

          case length(guids) do
            1 ->
              [logged_guid] = guids

              {username, logged_guid} = logged_guid

              if is_login == false do
                if logged_guid != guid do
                  redirect(conn, to: "/login")
                end
              end

            _ ->
              redirect(conn, to: "/login")
          end

        _ ->
          if is_login == false do
            redirect(conn, to: "/login")
          end
      end
    end

    if is_login == false do
      username = get_session(conn, :username)

      if username == nil do
        redirect(conn, to: "/login")
      end
    end

    conn
  end
end
