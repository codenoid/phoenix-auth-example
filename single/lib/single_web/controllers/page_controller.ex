defmodule SingleWeb.PageController do
  use SingleWeb, :controller

  def index(conn, _params) do
    username = get_session(conn, :username)
    render(conn, "index.html", username: username)
  end

  def login_view(conn, _params) do
    conn = put_layout(conn, false)
    render(conn, "login.html", token: get_csrf_token())
  end

  def login(conn, %{"username" => username, "password" => password} = params) do
    # query = from(u in User, where: u.username == ^username)
    # result = Repo.all(query)
    # compare hashed password with `Bcrypt.verify_pass(password, hashed_password)`
    if username == "admin" do
      if password == "password" do
        guid = conn.req_cookies["guid"]

        :ets.insert(:web_session, {username, guid})
        :ets.insert(:web_session, {guid, username})

        conn
        |> put_session(:username, username)
        |> redirect(to: "/")
      end
    end

    redirect(conn, to: "/login")
  end

  def logout(conn, _params) do
    guid = conn.req_cookies["guid"]

    :ets.delete(:danilla_session, guid)

    conn
    |> clear_session
    |> redirect(to: "/login")
  end
end
