module SpreeEssentialBlog
  
  class CustomHooks < Spree::ThemeSupport::HookListener

    insert_after :admin_configurations_menu, 'blog/admin/configurations/disqus_config'
  
  end
  
end
