# Spree Essential Blog [![Build Status](https://secure.travis-ci.org/citrus/spree_essential_blog.png)](http://travis-ci.org/citrus/spree_essential_blog)


A complete blogging solution for [Spree Commerce](http://spreecommerce.com) with multiple-blogs, archives, categories, tags, disqus comments and related products.

This extension relies on [spree_essentials](https://github.com/citrus/spree_essentials) for it's editor, uploads admin and tab in the admin.


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------


If you don't already have an existing Spree site, [click here](https://gist.github.com/946719) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Otherwise, follow these steps to get up and running with spree_essential_blog:

First, add spree_essential_blog to your Gemfile... it hasn't been released to Rubygems yet so we'll grab it from git.

```ruby
# Spree 1.1.x
gem 'spree_essential_blog', :git => 'git://github.com/citrus/spree_essential_blog.git', :branch => 'master'

# Spree 1.0.x
gem 'spree_essential_blog', :git => 'git://github.com/citrus/spree_essential_blog.git', :branch => '1.0.x'

# Spree 0.70.x
gem 'spree_essential_blog', '~> 0.1.0'

# Spree 0.60.x
gem 'spree_essential_blog', :git => 'git://github.com/citrus/spree_essential_blog.git', :branch => '0.60.x'
```    


Run the generators to create the migration files.

```bash
rails g spree_essentials:install
rails g spree_essentials:blog
```


Now migrate your database...

```bash
rake db:migrate
```

   
Boot your server and checkout the admin!

```bash
rails s
```   
    
### Sample Posts

If you'd like some sample posts, just use the rake command from your project:
   
```bash 
rake db:sample:blog
```


*Note: if you receive `identify: command not found` errors please ensure ImageMagick is installed.*


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Clone this repo to where you develop, bundle up, then run `dummier` to get the show started:

```bash
git clone git://github.com/citrus/spree_essential_blog.git
cd spree_essential_blog
bundle install
bundle exec dummier
```


This will generate a fresh rails app in test/dummy, install spree & spree_essential_blog, then migrate the test database. Sweet.

Now run the tests with:

```bash
rake
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

You can easily use the `test/dummy` app as a demo of spree_essential_blog. Just `cd` to where you develop and run:
  
```bash  
git clone git://github.com/citrus/spree_essential_blog.git
cd spree_essential_blog
cp test/dummy_hooks/after_migrate.rb.sample test/dummy_hooks/after_migrate.rb
bundle install
bundle exec dummier
cd test/dummy
bundle exec rails s
```


Setup is complete. Open `localhost:3000/blog` in your browser to see your posts.


------------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------------

**0.1.0 - 2011/12/15**

* Release v0.1.0


**2011/12/15**

* Remove spork dev dependency


**2011/12/14**

* Add Spree 0.70.x compatibility


**2011/8/9**

* Pulled [GH2](https://github.com/citrus/spree_essential_blog/pull/2) (Thanks [@dv](https://github.com/dv)!) 


**2011/6/7**

* Added Disqus for comments
* Re-namespaced from Admin::Blog to Blog::Admin
* Added more tests for categories


**2011/6/6**

* Pulled [GH1](https://github.com/citrus/spree_essential_blog/pull/1) (Thanks [@detierno](https://github.com/detierno)!)
* Switched to [dummier](https://github.com/citrus/dummier) for demo & testing
* Improved testing
* Improved documentation


**2011/4/13 - 2011/5/27**

* Initial development


------------------------------------------------------------------------------
Contributors
------------------------------------------------------------------------------

* Spencer Steffen ([@citrus](https://github.com/citrus))
* Milo Delgado ([@moladukes](https://github.com/moladukes))
* Pierre Basil ([@kpitn](https://github.com/kpitn))
* Denis Tierno ([@detierno](https://github.com/detierno))
* David Verhasselt ([@dv](https://github.com/dv))
* Kyle West ([@kylewest](https://github.com/kylewest))
* Phil Pirozhkov ([pirj](https://github.com/pirj))


If you'd like to help out feel free to fork and send me pull requests!

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 Spencer Steffen & Citrus, released under the New BSD License All rights reserved.
