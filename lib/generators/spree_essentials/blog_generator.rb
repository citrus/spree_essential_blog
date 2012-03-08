module SpreeEssentials
  module Generators
    class BlogGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essentials_blog"
      
      class_option :add_stylesheets, :type => :boolean, :default => true, :banner => "Append spree_essential_blog to store/all.css"
      
      def copy_migrations
        rake "spree_essential_blog:install:migrations"
      end
      
      def append_stylesheets
        return unless options[:add_stylesheets]
        gsub_file "app/assets/stylesheets/store/all.css", "*/", "*= require store/spree_essential_blog\n*/"
      end

    end
  end
end
