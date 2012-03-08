class CreateSpreeBlogs < ActiveRecord::Migration
  def self.up
    create_table :spree_blogs do |t|
      t.string     :title,     :required => true
      t.string     :path,      :required => true
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_blogs
  end
end
