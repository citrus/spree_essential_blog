class Admin::Blog::PostsController < Admin::ResourceController
  
  private
    
    update.before :set_category_ids
    
    def set_category_ids
      params[:post][:post_category_ids].reject!{|i| i.to_i == 0 }
    end
    
    def translated_object_name
      I18n.t('post.model_name')
    end
    
    def location_after_save
      params[:redirect_to] || object_url
    end 
    
    def find_resource
	  	@object ||= Post.find_by_path(params[:id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "posted_at.desc"
      @search = Post.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
