require "spree_essentials"
require "acts-as-taggable-on"

require "spree_essential_blog/version"
require "spree_essential_blog/engine"

module SpreeEssentialBlog

  def self.tab
    { :label => "Posts", :route => :admin_posts }
  end
  
  def self.sub_tab
    [:posts, { :label => "spree.admin.subnav.posts", :match_path => "/posts" }]
  end
      
end

SpreeEssentials.register :blog, SpreeEssentialBlog
