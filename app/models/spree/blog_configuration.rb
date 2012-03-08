class Spree::BlogsConfiguration < Spree::Preferences::Configuration
  
  preference :disqus_shortname,  :string, :default => ''
  
end
