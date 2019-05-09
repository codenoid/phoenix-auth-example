# Phoenix Auth Example

so basically : 

1. Multi Session is just like facebook, gmail or github, you can login anywhere without terminating other session
2. Single Session is, when you login (new session), your old session will be terminated (logged out)

Multi Session Tech : 
 - I only use phoenix session to save session data

https://github.com/codenoid/phoenix-auth-example/blob/master/multi/lib/multi_web/controllers/page_controller.ex
https://github.com/codenoid/phoenix-auth-example/blob/master/multi/lib/multi_web/helper/session.ex

Single Session Tech : 
 - I use ETS for saving where this username is assigned for (*for guid cookie)
 - Phoenix session to save session data
 - I prefer to use redis (ETS replacement for scaling)

https://github.com/codenoid/phoenix-auth-example/blob/master/single/lib/single/application.ex
https://github.com/codenoid/phoenix-auth-example/blob/master/single/lib/single_web/controllers/page_controller.ex
https://github.com/codenoid/phoenix-auth-example/blob/master/single/lib/single_web/helper/session.ex

## Usage

```bash
git clone https://github.com/codenoid/phoenix-auth-example
cd phoenix-auth-example
cd single # pick one
mix deps.get
cd assets && npm install
cd .. && mix phx.server
google-chrome "http://localhost:4000" # login 1
google-chrome "http://localhost:4000" --incognito # login 2, login 1 will be destroyed
```
