class Blog::Admin::PostCategoriesController < Admin::ResourceController
  
  before_filter :load_data
  
  def location_after_save
    admin_post_categories_url(@post)
  end
  
  private
    
    def translated_object_name
      I18n.t('post_category.model_name')
    end
      
    def load_data
      @post = Post.find_by_path(params[:post_id])
      @post_categories = PostCategory.all
    end
  
end