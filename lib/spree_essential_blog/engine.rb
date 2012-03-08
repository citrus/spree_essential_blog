module SpreeEssentialBlog  
  class Engine < Rails::Engine
  
    engine_name "spree_essential_blog"

    config.autoload_paths += %W(#{config.root}/lib)

    config.to_prepare do
    
      SpreeEssentialBlog::Config = Spree::BlogConfiguration.new unless SpreeEssentialBlog.const_defined?(:Config)
      
      Dir.glob File.expand_path("../../../app/**/*_decorator.rb", __FILE__) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob File.expand_path("../../..//app/overrides/**/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
    end
    
  end
end
