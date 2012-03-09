class CreateDefaultBlog < ActiveRecord::Migration
  def self.up
    @blog = Spree::Blog.create(:name => "Blog", :permalink => "blog")
    Spree::Post.update_all(:blog_id => @blog.id)
  end

  def self.down
  end
end
