require 'generators/essentials_base'

module SpreeEssentialBlog
  module Generators
    class InstallGenerator < SpreeEssentials::Generators::EssentialsBase
      
      desc "Installs required migrations for spree_essentials_blog"
      source_root File.expand_path("../../templates/db/migrate", __FILE__)
            
      def copy_migrations
        migration_template "create_posts.rb",              "db/migrate/create_posts.rb"
        migration_template "create_post_products.rb",      "db/migrate/create_post_products.rb"
        migration_template "acts_as_taggable_on_posts.rb", "db/migrate/acts_as_taggable_on_posts.rb"
      end

    end
  end
end