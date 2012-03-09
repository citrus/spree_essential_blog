#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::PostCategoryIntegrationTest < SpreeEssentials::IntegrationCase
  
  include Spree::Blogs::PostsHelper
  
  def setup
    Spree::Blog.destroy_all
    Spree::PostCategory.destroy_all
    @blog = Factory(:spree_blog)
    @categories = %w(Jellies Peanuts Butters).map{ |i| Factory.create(:spree_post_category, :name => i) }
    @posts = Array.new(3) {|i| 
      post = Factory.create(:spree_post, :blog => @blog, :title => "Capy post #{i}", :posted_at => Time.now - i.days, :categories => [@categories.slice(i)]) 
    }
  end
    
  should "get the blog page" do
    visit spree.blog_posts_path(@blog)
    within ".post-sidebar .post-categories" do
      assert_seen "Categories"
      @categories.each do |i|
        assert has_link?(i.name, :href => spree.post_category_path(@blog, i))
      end
    end    
  end
    
  should "only have the first post in the first category" do
    @post = @posts.shift
    puts @blog.inspect
    puts spree.post_category_path(@blog, @categories.first)
    visit spree.post_category_path(@blog, @categories.first)
    assert_seen @post.title, :within => ".post-title h2"
    within "#content .posts" do
      @posts.each do |i|
        assert !has_content?(i.title)
      end
    end
  end
  
end
