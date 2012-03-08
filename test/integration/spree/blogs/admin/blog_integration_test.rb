#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::Admin::BlogIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Blog.destroy_all
    @labels = %(Title, Path).split(', ')
    @values = %(Blog, /blog).split(', ')
  end
  
  context "create a blog" do
    
    should "validate blog" do
      visit spree.new_admin_blog_path
      click_button "Create"
      within "#errorExplanation" do
        assert_seen "2 errors prohibited this record from being saved:"
        assert_seen "Title can't be blank"
        assert_seen "Path can't be blank"
      end
    end
      
    should "Create a new blog" do
      visit spree.admin_blogs_path
      btn = find("#new_blog_link").native
      assert_match /#{spree.new_admin_blog_path}$/, btn.attribute('href')
      assert_equal "New Blog", btn.text
      btn.click
      within "#new_spree_blog" do
        fill_in "Title", :with => "Blog"
        fill_in "Path", :with => "/blog"
      end
      click_button "Create"
      assert_flash :notice, %(Blog "Blog" has been successfully created!)
    end
  
  end
  
  context "an existing blog" do    
    
    setup do
      @blog = Factory.create(:spree_blog)
    end
    
    should "edit and update" do
      visit spree.admin_blogs_path
      within "tr#spree_blog_#{@blog.id}" do
        click_link "Edit"
      end
      within "#edit_spree_blog_#{@blog.id}" do
        fill_in "Title", :with => "News"
        fill_in "Path", :with => "/news"
      end
      click_button "Update"
      assert_equal spree.admin_blogs_path, current_path
      assert_flash :notice, %(Blog "News" has been successfully updated!)
    end
    
    should "redirect when visting show" do
      visit spree.admin_blog_path(@blog)
      assert_equal spree.admin_blogs_path, current_path
    end
    
    should "get destroyed" do
      visit spree.admin_blogs_path
      within "tr#spree_blog_#{@blog.id}" do
        find("a[href='#']").click
      end      
      assert find_by_id("popup_ok").click
    end
    
  end
  
end
