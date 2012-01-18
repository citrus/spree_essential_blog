class Spree::Blog::PostCategoriesController < Spree::BaseController
  helper 'spree/blog/posts'
  
  before_filter :get_sidebar, :only => [:index, :search, :show]
  
  
  def show
    @category = Spree::PostCategory.find_by_permalink(params[:id])
    @posts = @category.posts.live
    @posts = @posts.page(params[:page]).per(Spree::Post.per_page)
  end
  
  def get_sidebar    
    @archive_posts = Spree::Post.live.limit(10)
    @post_categories = Spree::PostCategory.all
    get_tags
  end
  
  def get_tags
    @tags = Spree::Post.live.tag_counts.order('count DESC').limit(25)
  end
  
end