Deface::Override.new(:virtual_path  => "spree/shared/_store_menu",
                     :name          => "spree_essential_blog_main_menu_items",
                     :insert_after  => "#home-link[data-hook]",
                     :partial       => "spree/shared/blog_main_menu_items",
                     :disabled      => false)