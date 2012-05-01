#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::Admin::BlogsIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Blog.destroy_all
  end
  
  context "create a blog" do
    
    should "validate blog" do
      visit spree.new_admin_blog_path
      click_button "Create"
      within "#errorExplanation" do
        assert_seen "errors prohibited this record from being saved:"
        assert_seen "Name can't be blank"
        assert_seen "Permalink is invalid"
      end
    end
      
    should "Create a new blog" do
      visit spree.admin_blogs_path
      btn = find("#new_blog_link").native
      assert_match /#{spree.new_admin_blog_path}$/, btn.attribute('href')
      assert_equal "New Blog", btn.text
      btn.click
      within "#new_blog" do
        fill_in "Name", :with => "Blog"
        fill_in "Permalink", :with => "blog"
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
      within "tr#blog_#{@blog.id}" do
        click_link "Edit"
      end
      within "#edit_blog_#{@blog.id}" do
        fill_in "Name", :with => "News"
        fill_in "Permalink", :with => "news"
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
      within "tr#blog_#{@blog.id}" do
        find("a[href='#']").click
      end      
      assert find_by_id("popup_ok").click
    end
    
  end
  
end
