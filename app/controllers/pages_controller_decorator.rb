if defined?(PagesController) do
  PagesController.instance_eval do
    helper 'blog/posts'
  end  
end