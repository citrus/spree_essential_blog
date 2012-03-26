module SpreeEssentialBlog::PostsControllerHelper

  extend ActiveSupport::Concern

  included do
    helper 'spree/blogs/posts'
    before_filter :get_blog  
  end
  
private
  
  def default_scope
    @blog.posts.live
  end
  
  def get_sidebar
    @archive_posts = default_scope.limit(10)
    @post_categories = @blog.categories.order(:name).all
    get_tags
  end
  
  def get_tags
    @tags = default_scope.tag_counts.order('count DESC').limit(25)
  end

  def get_blog
    @blog = Spree::Blog.find_by_permalink!(params[:blog_id])
  end
  
end
