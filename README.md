RubyApp
=======

Little ruby application template. For creates light ruby apps (daemons, EventMachine-apps, ...). 
Supports bundler, environments, rails dirs tree.

```ruby
gem install ruby-app
```

    $ ruby-app new_app
    $ cd new_app && bundle
    
Run like:

    $ ./bin/dummy
    $ APP_ENV=production ./bin/dummy
    