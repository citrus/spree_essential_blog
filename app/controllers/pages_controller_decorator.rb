if defined?(PagesController)
  PagesController.instance_eval do
    helper 'blog/posts'
  end  
end