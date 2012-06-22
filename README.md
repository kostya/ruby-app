RubyApp
=======

Little ruby application template. For creates light ruby apps (daemons, EventMachine-apps, ...). 
Supports bundler, environments, rails dirs tree.

    $ gem install ruby-app


    $ ruby-app new_app
    $ cd new_app && bundle
    
Run like (default env is development): 

    $ ./bin/example
    $ APP_ENV=production ./bin/example


Generate app with ActiveRecord support:

    $ ruby-app new_app --ar
    
