class AddSpreeNamespaceToBlog < ActiveRecord::Migration
  def up
    rename_table :posts, :spree_posts
    rename_table :post_categories, :spree_post_categories
    rename_table :post_categories_posts, :spree_post_categories_posts
    rename_table :post_products, :spree_post_products
  end

  def down
    rename_table :spree_posts, :posts
    rename_table :spree_post_categories, :post_categories
    rename_table :spree_post_categories_posts, :post_categories_posts
    rename_table :spree_post_products, :post_products
  end
end