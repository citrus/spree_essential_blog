class Spree::Blog::Admin::PostsController < Spree::Admin::ResourceController

  def index
    @pages = collection
  end

  private
    
    update.before :set_category_ids
    
    def set_category_ids
      if params[:post] && params[:post][:post_category_ids].is_a?(Array)
        params[:post][:post_category_ids].reject!{|i| i.to_i == 0 }
      end
    end
    
    def translated_object_name
      I18n.t('post.model_name')
    end
    
    def location_after_save
      object_url
    end 
    
    def find_resource
	  	@object ||= Spree::Post.find_by_path(params[:id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "posted_at.desc"
      @search = Spree::Post.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Post.per_page)
    end

end
