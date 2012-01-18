if defined?(Spree::PagesController)
  Spree::PagesController.instance_eval do
    helper 'spree/blog/posts'
  end  
end