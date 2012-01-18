class Spree::Blog::Admin::PostCategoriesController < Spree::Admin::ResourceController
  
  before_filter :load_data

  private

    def location_after_save
      admin_post_categories_url(@post)
    end

    def translated_object_name
      I18n.t('post_category.model_name')
    end
      
    def load_data
      @post = Spree::Post.find_by_path(params[:post_id])
      @post_categories = Spree::PostCategory.all
    end
  
end
