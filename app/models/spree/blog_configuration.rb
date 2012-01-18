class Spree::BlogConfiguration < Spree::Preferences::Configuration
  
  preference :disqus_shortname,  :string, :default => ''
  
end
