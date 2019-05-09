defmodule MultiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :multi

  socket "/socket", MultiWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :multi,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_multi_key",
    signing_salt: "eVhKR4H/"

  # you will need to check session in CheckSessionPlug, to prevent
  # session not fetched error, call `plug :fetch_session` before
  # plug CheckSessionPlug
  plug :fetch_session

  # Before request-like function that check is cookie has logged
  # session or not, if not redirect to "/login", this function
  # works on all route except /login
  plug CheckSessionPlug

  plug MultiWeb.Router
end
