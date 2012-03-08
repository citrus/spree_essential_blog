class Spree::Blogs::Admin::DisqusSettingsController < Spree::Admin::BaseController

  def show
    @preferences = ['disqus_shortname']
    @config = Spree::BlogsConfiguration.new
  end

  def edit
    @preferences = ['disqus_shortname']
    @config = Spree::BlogsConfiguration.new
  end

  def update
    config = Spree::BlogsConfiguration.new

    params.each do |name, value|
      next unless config.has_preference? name
      config[name] = value
    end

    redirect_to admin_disqus_settings_path
  end

end
