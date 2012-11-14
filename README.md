RubyApp
=======

Ruby micro framework for easy create ruby applications (daemons, EventMachine-apps, db-apps, cli...).
Features: bundler, environments, activesupport, rails dirs tree. Fast loading and low memory using.

    $ gem install ruby-app


    $ ruby-app new app
    $ cd app && bundle
    
Run like (default env is development): 

    $ ./bin/example
    $ APP_ENV=production ./bin/example


Generate app with ActiveRecord support:

    $ ruby-app new app --ar
    
