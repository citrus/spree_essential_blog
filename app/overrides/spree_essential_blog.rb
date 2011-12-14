Deface::Override.new(:virtual_path  => "admin/configurations/index",
                     :name          => "blog_disqus_admin_configurations_menu",
                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :partial       => "blog/admin/configurations/disqus_config",
                     :disabled      => false)
