class Admin::Blog::PostCategoriesController < Admin::ResourceController
  
  before_filter :load_data
  
  # def edit
  #   @category = PostCategory.find(params[:id])
  # end
  # 
  # def update
  #   @category = PostCategory.find(params[:id])
  #   flash[:notice] = 'Category was successfully updated.' if @category.update_attributes(params[:post_category])
  #   respond_to do |format|
  #     format.html { redirect_to admin_posts_path }
  #   end
  # end
  
private
  
  def load_data
    @post = Post.find_by_path(params[:post_id])
    @post_categories = PostCategory.all
  end
  
end