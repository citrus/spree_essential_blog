class Blog::Admin::DisqusSettingsController < Admin::BaseController

  def show
    @config = BlogConfiguration.current
    @preferences = ['disqus_shortname']
  end
  
  def edit
    @config = BlogConfiguration.current
    @preferences = ['disqus_shortname']
  end
  
  def update
    BlogConfiguration.current.update_attributes(params[:blog_configuration])
    respond_to do |format|
      format.html {
        redirect_to admin_disqus_settings_path
      }
    end
  end  

end
