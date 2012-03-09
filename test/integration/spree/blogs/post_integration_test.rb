#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'
  

class Spree::Blogs::PostIntegrationTest < SpreeEssentials::IntegrationCase
  
 
  include Spree::Blogs::PostsHelper
  
  def setup
    Spree::Blog.destroy_all
    @blog = Factory(:spree_blog)
  end
   

  def assert_no_post(post)
    within "#sidebar .post-archive" do
      assert !has_link?(post.title)        
    end
    within "#content .posts" do
      assert !has_link?(post.title)        
    end
    within ".tag-cloud ul.tags" do
      post.tags.each do |tag|
        assert !has_link?(tag.name)
      end
    end
  end
  
  def assert_has_post(post)
    within "#sidebar .post-archive" do
      assert has_link?(post.title)        
    end
    within "#content .posts" do
      assert has_link?(post.title)        
    end
    within ".tag-cloud ul.tags" do
      post.tags.each do |tag|
        assert has_link?(tag.name)
      end
    end
  end


  
  context "with some posts" do
    
    setup do
      11.times{ |i| Factory.create(:spree_post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) }
      assert_equal 11, Spree::Post.count
    end
    
    should "get the blog page" do
      visit spree.blog_posts_path(@blog)
      # first post
      assert has_link?("Capy post 1")
      # last post
      assert has_link?("Capy post 9")
      # archive link
      assert has_link?("View Full Archive")
      # tag link
      assert has_link?("peanut butter")
      # page two
      assert has_link?("2")
      assert has_link?("Next ›")
    end
    
    should "get a blog post" do
      @post = Spree::Post.first
      visit spree.full_post_path(@blog, @post.year, @post.month, @post.day, @post)
      within('h1') do
        assert has_content?(@post.title)
      end
    end
    
    should "get the archive" do
      visit spree.archive_posts_path(@blog)
      assert has_link?("Capy post 1")
      assert has_link?("Shop the Store")
    end
    
  end
  
  
  context "with a specific post" do
  
    setup do
      @post = Factory.create(:spree_post, :posted_at => DateTime.parse("2011/2/17"), :tag_list => "gruyere, emmentaler, fondue")
      assert_equal 1, Spree::Post.count
    end
  
    should "find by seo path" do
      visit post_seo_path(@blog, @post)
      assert_seen "Peanut Butter Jelly Time", :within => ".post-title h1"
      assert_seen "Thursday February 17, 2011", :within => ".post-title h5"
      within ".post-tags" do
        assert has_link?("gruyere")
        assert has_link?("emmentaler")
        assert has_link?("fondue")
      end       
    end
    
    should "not find by tags" do
      visit spree.search_posts_path(@blog, :query => "some crazy random query")
      assert_seen "No posts found!", :within => ".posts h1"
    end
    
    should "find by tags" do
      visit spree.search_posts_path(@blog, :query => "emmentaler")
      assert has_link?("Peanut Butter Jelly Time", :href => post_seo_path(@blog, @post))
      assert has_link?("Read More", :href => post_seo_path(@blog, @post))
    end
  
  end
  
  
  context "unpublished posts" do
  
    setup do
      @tags = %(totally, not published).split(", ")
      @post = Factory.create(:spree_post, :title => "Unpublished Post", :tag_list => @tags.join(", "), :live => false)
      assert_equal 1, Spree::Post.count
    end
    
    should "not include post in index" do
      visit spree.blog_posts_path(@blog)
      assert_no_post(@post)
    end
    
    should "not include post in day specific index" do
      visit spree.post_date_path(@blog, :year => @post.year, :month => @post.month, :day => @post.day)
      assert_no_post(@post)
    end    
    
    should "not include post in month specific index" do
      visit spree.post_date_path(@blog, :year => @post.year, :month => @post.month)
      assert_no_post(@post)
    end
    
    should "not include post in year specific index" do
      visit spree.post_date_path(@blog, :year => @post.year)
      assert_no_post(@post)
    end
    
    should "not include post in search results" do
      @tags.each do |tag|
        visit spree.search_posts_path(@blog, tag)
        assert_no_post(@post)
      end
    end
    
  end
  
  
  context "published posts" do
    
    setup do
      @tags = %(totally, published).split(", ")
      @post = Factory.create(:spree_post, :title => "Published Post", :tag_list => @tags.join(", "), :live => true)
      assert_equal 1, Spree::Post.count
    end
    
    should "not include post in index" do
      visit spree.blog_posts_path(@blog)
      assert_has_post(@post)
    end
    
    should "not include post in day specific index" do
      visit spree.post_date_path(@blog, :year => @post.year, :month => @post.month, :day => @post.day)
      assert_has_post(@post)
    end    
    
    should "not include post in month specific index" do
      visit spree.post_date_path(@blog, :year => @post.year, :month => @post.month)
      assert_has_post(@post)
    end
    
    should "not include post in year specific index" do
      visit spree.post_date_path(@blog, :year => @post.year)
      assert_has_post(@post)
    end
    
    should "not include post in search results" do
      @tags.each do |tag|
        visit spree.search_posts_path(@blog, tag)
        assert_has_post(@post)
      end
    end
    
  end
   
end
  
  
  
  
  # [todo] make these capy tests
  #
  #context "published, dated posts" do
  #
  #  setup do
  #    @date = DateTime.parse("2011/3/20 16:00")
  #    @post = Factory.create(:spree_post, :posted_at => @date)
  #    10.times {|i| Factory.create(:spree_post, :title => "Today's Sample Post #{i}",      :posted_at => @date) }
  #    10.times {|i| Factory.create(:spree_post, :title => "Last Weeks's Sample Post #{i}", :posted_at => @date - 1.week) }
  #    10.times {|i| Factory.create(:spree_post, :title => "Last Month's Sample Post #{i}", :posted_at => @date - 1.month) }
  #    10.times {|i| Factory.create(:spree_post, :title => "Last Years's Sample Post #{i}", :posted_at => @date - 1.year) }
  #  end
  #
  #  should "assert proper post count" do
  #    assert_equal 41, Post.count
  #  end
  #
  #  should "paginate posts by day" do
  #    get :index, :year => @post.year, :month => @post.month, :day => @post.day
  #    assert_equal 10, assigns(:posts).length
  #    assert_equal 11, assigns(:posts).total_entries
  #    assert_equal 2,  assigns(:posts).total_pages
  #    assert_response :success
  #  end
  #  
  #  should "get posts by month" do
  #    get :index, :year => @post.year, :month => @post.month
  #    assert_equal 10, assigns(:posts).length
  #    assert_equal 21, assigns(:posts).total_entries
  #    assert_equal 3,  assigns(:posts).total_pages
  #    assert_response :success
  #  end
  #  
  #  should "get posts by year" do
  #    get :index, :year => @post.year
  #    assert_not_nil assigns(:posts)
  #    assert_equal 10, assigns(:posts).length
  #    assert_equal 31, assigns(:posts).total_entries
  #    assert_equal 4,  assigns(:posts).total_pages
  #    assert_response :success
  #  end
  #
  #end
