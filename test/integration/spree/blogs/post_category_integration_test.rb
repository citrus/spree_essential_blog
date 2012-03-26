#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::PostCategoryIntegrationTest < SpreeEssentials::IntegrationCase
  
  include Spree::Blogs::PostsHelper
  
  def setup
    Spree::Blog.destroy_all
    Spree::PostCategory.destroy_all
    @blog = Factory(:spree_blog)
    @news = Factory(:spree_blog, :name => "News")
    @blog_categories = %w(Jellies Peanuts Butters).map{ |i| Factory.create(:spree_post_category, :name => i) }
    @news_categories = %w(Events Press Boring).map{ |i| Factory.create(:spree_post_category, :name => i) }
    @blog_posts = Array.new(3) {|i| 
      post = Factory.create(:spree_post, :blog => @blog, :title => "Capy Post #{i}", :posted_at => Time.now - i.days, :categories => [@blog_categories.slice(i)]) 
    }
    @news_posts = Array.new(3) {|i| 
      post = Factory.create(:spree_post, :blog => @news, :title => "Capy News #{i}", :posted_at => Time.now - i.days, :categories => [@news_categories.slice(i)])
    }
  end
  
  should "get the blog page" do
    visit spree.blog_posts_path(@blog)
    within ".post-sidebar .post-categories" do
      assert_seen "Categories"
      @blog_categories.each do |i|
        assert has_link?(i.name, :href => spree.post_category_path(@blog, i))
      end
      @news_categories.each do |i|
        assert !has_link?(i.name)
      end
    end
  end
  
  should "get the news page" do
    visit spree.blog_posts_path(@news)
    within ".post-sidebar .post-categories" do
      assert_seen "Categories"
      @news_categories.each do |i|
        assert has_link?(i.name, :href => spree.post_category_path(@news, i))
      end
      @blog_categories.each do |i|
        assert !has_link?(i.name)
      end
    end
  end
  
  should "only have the first post in the first category" do
    @post = @blog_posts.shift
    visit spree.post_category_path(@blog, @blog_categories.first)
    assert_seen @post.title, :within => ".post-title h2"
    within "#content .posts" do
      @blog_posts.each do |i|
        assert !has_content?(i.title)
      end
    end
  end
  
end
