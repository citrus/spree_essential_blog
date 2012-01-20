# Install Spree Migrations
rake "spree:install:migrations"

# Mount Spree Engine
insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

run "bundle exec rails g spree_essentials:install"
run "bundle exec rails g spree_essentials:blog"

# remove all stylesheets except core  
%w(admin store).each do |ns|
  js  = "app/assets/javascripts/#{ns}/all.js"
  css = "app/assets/stylesheets/#{ns}/all.css"
  remove_file js
  remove_file css
  template "#{ns}/all.js", js
  template "#{ns}/all.css", css
end
