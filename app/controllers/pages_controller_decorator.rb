if defined?(Spree::PagesController)
  Spree::PagesController.instance_eval do
    helper 'spree/blogs/posts'
  end  
end
