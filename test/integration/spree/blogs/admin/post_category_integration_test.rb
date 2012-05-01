#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Spree::Blogs::Admin::PostCategoryIntegrationTest < SpreeEssentials::IntegrationCase
  
  def setup
    Spree::Post.destroy_all
    Spree::PostCategory.destroy_all
    @post = Factory.create(:spree_post)
    @category = Factory.create(:spree_post_category)
  end
  
  should "have a link to post categories" do
    visit spree.admin_post_path(@post)
    within ".sidebar.post-menu" do
      assert has_link?("Categories")
    end
  end
  
  should "get the post categories index" do
    visit spree.admin_post_categories_path(@post)
    assert_seen "Categories", :within => ".sidebar.post-menu li.active"
    assert_seen "Manage Categories", :within => ".edit_post legend"
    assert_seen @category.name, :within => "tr#post_category_#{@category.id} td label"
    assert has_selector?("button[type=submit]")
    assert has_selector?("a#btn_new_category")
  end
  
  should "add a new post category" do
    visit spree.admin_post_categories_path(@post)
    click_link "btn_new_category"
    fill_in "Name", :with => "Just a Category"
    fill_in "Permalink", :with => "just-a-category"
    click_button "Create"
    @category = Spree::PostCategory.last
    assert_equal spree.admin_post_categories_path(@post), current_path
    assert_flash :notice, %(Post category "#{@category.name}" has been successfully created!)
    assert_seen @category.name, :within => "tr#post_category_#{@category.id} td label"
  end
  
  should "edit existing post category" do
    visit spree.edit_admin_post_category_path(@post, @category.id)
    assert_equal @category.name, find_field("Name").value
    assert_equal @category.permalink, find_field("Permalink").value
    fill_in "Name", :with => "Not just a Category"
    fill_in "Permalink", :with => "not-just-a-category"
    click_button "Update"
    assert_equal spree.admin_post_categories_path(@post), current_path
    assert_flash :notice, %(Post category "Not just a Category" has been successfully updated!)
    assert_seen "Not just a Category", :within => "tr#post_category_#{@category.id} td label"    
  end
  
  should "destroy the post category" do
    visit spree.admin_post_categories_path(@post)
    find("tr#post_category_#{@category.id} td.options a[href='#']").click
    assert find_by_id("popup_ok").click
  end  
  
  should "link a post category" do
    visit spree.admin_post_categories_path(@post)
    assert !field_labeled(@category.name).checked?
    check @category.name
    click_button "Update"
    assert field_labeled(@category.name).checked?
    assert_equal spree.admin_post_categories_path(@post), current_path
    assert_flash :notice, %(Post "#{@post.title}" has been successfully updated!)
  end 
   
  should "unlink a post category" do
    @post.categories << @category
    @post.save
    visit spree.admin_post_categories_path(@post.reload)
    assert field_labeled(@category.name).checked?
    uncheck @category.name
    click_button "Update"
    assert_equal spree.admin_post_categories_path(@post), current_path
    assert !field_labeled(@category.name).checked?
    assert_flash :notice, %(Post "#{@post.title}" has been successfully updated!)
  end
  
  context "with multiple categories" do
  
    setup do
      Spree::PostCategory.destroy_all
      @categories = %w(one two three four five).map{|i| Factory.create(:spree_post_category, :name => i) }
    end
    
    should "link a multiple post categories" do
      visit spree.admin_post_categories_path(@post)
      @categories.each do |category|
        assert !field_labeled(category.name).checked?
      end
      @categories.take(3).each do |category|
        check category.name
      end
      click_button "Update"
      @categories.take(3).each do |category|
        assert field_labeled(category.name).checked?
      end
      @categories.slice(3, 2).each do |category|
        assert !field_labeled(category.name).checked?
      end
      assert_equal spree.admin_post_categories_path(@post), current_path
      assert_flash :notice, %(Post "#{@post.title}" has been successfully updated!)
    end 
   
    should "unlink multiple post category" do
      @post.categories = @categories.take(3)
      @post.save
      visit spree.admin_post_categories_path(@post.reload)
      @categories.take(3).each do |category|
        assert field_labeled(category.name).checked?
      end
      @categories.take(3).each do |category|
        uncheck category.name
      end
      click_button "Update"
      @categories.each do |category|
        assert !field_labeled(category.name).checked?
      end
      assert_equal spree.admin_post_categories_path(@post), current_path
      assert_flash :notice, %(Post "#{@post.title}" has been successfully updated!)
    end 
       
  end
  
end
