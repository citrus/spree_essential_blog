#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::Admin::PostIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Post.destroy_all
    @labels = %(Title, Posted At, Body, Tags).split(', ')
    @values = %(Just a post, #{Time.now}, #{Faker::Lorem.paragraphs(1 + rand(4)).join("\n\n")}, one tag).split(', ')
  end
  
  should "have a link to new post" do
    visit spree.admin_posts_path
    btn = find(".actions a.button").native
    assert_match /#{spree.new_admin_post_path}$/, btn.attribute('href')
    assert_equal "New Post", btn.text
  end
  
  should "get new post" do  
    visit spree.new_admin_post_path
    assert has_content?("New Post")
    within "#new_post" do
      @labels.each do |f|
        assert has_field?(f)
      end
    end
  end
    
  should "validate post" do
    visit spree.new_admin_post_path
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "2 errors prohibited this record from being saved:"
      assert_seen "Title can't be blank"
      assert_seen "Body can't be blank"
    end
  end
  
  should "create a post" do
    visit spree.new_admin_post_path
    within "#new_post" do
      @labels.each_with_index do |label, index|
      	fill_in label, :with => @values[index]      
      end
    end
    click_button "Create"
    assert_flash :notice, %(Post "Just a post" has been successfully created!)
  end  
  
  context "an existing post" do    
    setup do
      @post = Factory.create(:spree_post)
    end
    
    should "edit and update" do
      visit spree.edit_admin_post_path(@post)
      
      within "#edit_post_#{@post.id}" do
        @labels.each_with_index do |label, index|
          next if label == 'Posted At'
        	fill_in label, :with => @values[index].reverse      
        end
      end
      click_button "Update"
      assert_equal spree.admin_post_path(@post.reload), current_path
      assert_flash :notice, %(Post "tsop a tsuJ" has been successfully updated!)
    end
    
    should "get destroyed" do
      visit spree.admin_posts_path
      find("a[href='#']").click
      assert find_by_id("popup_ok").click
    end
    
  end
  
  context "several posts on multiple blogs" do
    
    BLOGS = %w(Blog News Press)
    
    setup do
      Spree::Blog.destroy_all
      @blogs = BLOGS.map{|i| Factory(:spree_blog, :name => i) }
      @blogs.each_with_index do |blog, i|
        Factory(:spree_post, :blog => blog, :title => "Post on #{blog.name}", :posted_at => Time.now - i.minutes)
      end
    end
  
    should "see all posts" do
      visit spree.admin_posts_path
      BLOGS.each_with_index do |name, i|
        assert_seen "Post on #{name}", :within => "tbody tr:nth-child(#{i + 1})"
      end
    end
    
    BLOGS.each_with_index do |name, i|
      should "use filter to only show posts in `#{name}`" do
        visit spree.admin_posts_path
        within "#sidebar" do
          select name, :from => "Blog"
          click_button "Search"
        end
        assert_seen "Post on #{name}", :within => "tbody tr:first"
        within "tbody" do
          BLOGS.each do |other|
            next if name == other
            assert !has_content?("Post on #{other}")
          end
        end
      end
    end
  
  end
  
end
