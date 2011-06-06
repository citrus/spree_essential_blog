#! /usr/bin/env ruby
# encoding: UTF-8

require_relative '../test_helper'

class Blog::PostIntegrationTest < ActiveSupport::IntegrationCase
  
  include Blog::PostsHelper
  
  def setup
    Post.destroy_all
    11.times{ |i| Factory.create(:post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) }
  end
  
  
  should "get the blog page" do
    visit posts_path
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
    assert has_link?("Next →")
  end
  
  should "get a blog post" do
    @post = Post.first
    visit full_post_path(@post.year, @post.month, @post.day, @post)
    within('h1') do
      assert has_content?(@post.title)
    end
  end
  
  should "get the archive" do
    visit archive_posts_path
    assert has_link?("Capy post 1")
    assert has_link?("Shop the store")
  end
  
  
  
  
  context "with an existing post" do
  
    setup do
      @post = Factory.create(:post, :posted_at => DateTime.parse("2011/2/17"), :tag_list => "gruyere, emmentaler, fondue")
    end
  
    should "find by seo path" do
      visit post_seo_path(@post)
      assert_seen "Peanut Butter Jelly Time", :within => ".post-title h1"
      assert_seen "Thursday February 17, 2011", :within => ".post-title h5"
      within ".post-tags" do
        assert has_link?("gruyere")
        assert has_link?("emmentaler")
        assert has_link?("fondue")
      end       
    end
    
    should "not find by tags" do
      visit search_posts_path(:query => "some crazy random query")
      assert_seen "No posts found!", :within => ".posts h1"
    end
    
    should "find by tags" do
      visit search_posts_path(:query => "emmentaler")
      assert has_link?("Peanut Butter Jelly Time", :href => post_seo_path(@post))
      assert has_link?("Read More", :href => post_seo_path(@post))
    end
  
  end
  
  
  context "unpublished posts" do
  
    setup do
      Post.destroy_all
      @tags = "totally, not published"
      @post = Factory.create(:post, :title => "Unpublished Post", :tag_list => @tags, :live => false)
    end
    
    should "not include post in index" do
      visit posts_path
      within "#content .posts" do
        assert !has_link?("Unpublished Post")        
      end
      within ".tag-cloud ul.tags" do
        assert !has_link?("totally")
        assert !has_link?("not published")
      end
    end
    
    #should "not include post in day specific index" do
    #  get :index, :year => @post.year, :month => @post.month, :day => @post.day
    #  assert !assigns(:posts).include?(@post)
    #end
    #
    #should "not include post in month specific index" do
    #  get :index, :year => @post.year, :month => @post.month
    #  assert !assigns(:posts).include?(@post)
    #end
    #
    #should "not include post in year specific index" do
    #  get :index, :year => @post.year
    #  assert !assigns(:posts).include?(@post)
    #end
    #
    #should "not include post in search results" do
    #  get :search, :query => @tags
    #  assert !assigns(:posts).include?(@post)
    #end
    
  end
  
  #
  #context "published posts" do
  #
  #  setup do
  #    @date = DateTime.parse("2011/3/20 16:00")
  #    @post = Factory.create(:post, :posted_at => @date)
  #    10.times {|i| Factory.create(:post, :title => "Today's Sample Post #{i}",      :posted_at => @date) }
  #    10.times {|i| Factory.create(:post, :title => "Last Weeks's Sample Post #{i}", :posted_at => @date - 1.week) }
  #    10.times {|i| Factory.create(:post, :title => "Last Month's Sample Post #{i}", :posted_at => @date - 1.month) }
  #    10.times {|i| Factory.create(:post, :title => "Last Years's Sample Post #{i}", :posted_at => @date - 1.year) }
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

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end
