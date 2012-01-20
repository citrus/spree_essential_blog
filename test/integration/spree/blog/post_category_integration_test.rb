#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blog::PostCategoryIntegrationTest < ActiveSupport::IntegrationCase
  
  include Spree::Blog::PostsHelper
  
  def setup
    Spree::Post.destroy_all
    Spree::PostCategory.destroy_all
    @categories = %w(Jellies Peanuts Butters).map{ |i| Factory.create(:spree_post_category, :name => i) }
    3.times{|i| 
      post = Factory.create(:spree_post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) 
      post.categories = [@categories.slice(i)]
      post.save
    }
    @posts = Spree::Post.order(:id).all
  end
    
  should "get the blog page" do
    visit posts_path
    within ".post-sidebar .post-categories" do
      assert_seen "Categories"
      @categories.each do |i|
        assert has_link?(i.name, :href => post_category_path(i))
      end
    end    
  end
    
  should "only have the first post in the first category" do
    @post = @posts.shift
    visit post_category_path(@categories.first)
    assert_seen @post.title, :within => ".post-title h2"
    within "#content .posts" do
      @posts.each do |i|
        assert !has_content?(i.title)
      end
    end
  end
  
end
