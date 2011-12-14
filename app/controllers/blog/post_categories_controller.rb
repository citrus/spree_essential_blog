class Blog::PostCategoriesController < Spree::BaseController
  helper 'blog/posts'
  
  before_filter :get_sidebar, :only => [:index, :search, :show]
  
  
  def show
    @category = PostCategory.find_by_permalink(params[:id])
    @posts = @category.posts.live
    @posts = @posts.page(params[:page]).per(Post.per_page)
  end
  
  def get_sidebar    
    @archive_posts = Post.live.limit(10)
    @post_categories = PostCategory.all
    get_tags
  end
  
  def get_tags
    @tags = Post.live.tag_counts.order('count DESC').limit(25)
  end
  
end