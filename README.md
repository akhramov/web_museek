#### Configuration
Setup the TCP socket via musetup, set the interface password.

Edit .env file to match your data.

#### Launch

Requirements:
You need ruby 2.4.0+, elm 0.18.0

This will install deps:

```csh
% gem install bundler
% bundle install
```

This will launch the application (well, websocket server located at localhost:9292):

```% bundle exec rackup```

For debug purposes, the message code is printed to the console. Fear not, just wait a minute till peerstats messages (515) are gone.

Then you need to compile assets. Just launch elm-reactor:

```% elm-reactor```

Visit
http://127.0.0.1:8000/src/Main.elm/#transfers/upload

yay!


##### There's a lot work to do, but we rock.
