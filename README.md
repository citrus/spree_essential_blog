Spree Essential Blog
====================

A complete blogging solution for [Spree Commerce](http://spreecommerce.com)...


[todo] write more...


Installation
------------

If you don't already have an existing Spree site, [click here](https://gist.github.com/946719) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Otherwise, follow these steps to get up and running with spree_essential_blog:

First, add spree_essential_blog to your Gemfile... it hasn't been released to Rubygems yet so we'll grab them it git.

    gem 'spree_essential_blog', :git => 'git://github.com/citrus/spree_essential_blog.git'

Run the generators to create the migration files.

    rails g spree_essentials:install
    rails g spree_essentials:blog

Now migrate your database...

    rake db:migrate
    
Boot your server and checkout the admin!

    rails s
    
    
### Sample Posts

If you'd like some sample posts, just use the rake command from your project:
    
    rake db:sample:blog



Testing
-------

Clone this repo to where you develop, bundle up, then run `dummier` to get the show started:

    git clone git://github.com/citrus/spree_essential_blog.git
    cd spree_essential_blog
    bundle install
    bundle exec dummier

This will generate a fresh rails app in test/dummy, install spree & spree_essential_blog, then migrate the test database. Sweet.


### Spork
    
If you want to spork, run:

    bundle exec spork
        
In another window, run all tests:

    testdrb test/**/*_test.rb
    
Or just a specific test:

    testdrb test/unit/page_test.rb
  

### No Spork

If you don't want to spork, just use rake:

    rake
    
    

Demo
----

You can easily use the `test/dummy` app as a demo of spree_essential_blog. Just `cd` to where you develop and run:
    
    git clone git://github.com/citrus/spree_essential_blog.git
    cd spree_essential_blog
    mv lib/dummy_hooks/after_migrate.rb.sample lib/dummy_hooks/after_migrate.rb
    bundle install
    bundle exec dummier
    cd test/dummy
    rails s
    



Change Log
----------


**2011/6/6**

* added a few more tests
* pulled GH1 (Thanks [detierno](https://github.com/detierno)!)
* Switched to [dummier](https://github.com/citrus/dummier) for demo/testing
* Improved testing
* Improved documentation


**2011/4/13 - 2011/5/27**

* Initial development


Contributors
------------

* Spencer Steffen [citrus](https://github.com/citrus)
* Denis Tierno [detierno](https://github.com/detierno)

If you'd like to help out feel free to fork and send me pull requests!


License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.
