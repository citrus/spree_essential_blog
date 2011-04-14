module SpreeEssentialBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      desc "Configures your Rails application for use with spree_essentials"
      source_root File.expand_path("../../templates", __FILE__)

      def self.next_migration_number(path)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      def copy_migrations
        migration_template "create_articles.rb",           "db/migrate/create_articles.rb"
        migration_template "create_article_products.rb",   "db/migrate/create_article_products.rb"
        migration_template "acts_as_taggable_on_posts.rb", "db/migrate/acts_as_taggable_on_posts.rb"
      end

    end
  end
end