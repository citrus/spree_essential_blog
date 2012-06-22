#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'
  

class Spree::Blogs::BlogIntegrationTest < SpreeEssentials::IntegrationCase
  
  def setup
    Spree::Blog.destroy_all
  end
   
  context "with some blogs" do
    
    setup do
      3.times{ |i| Factory.create(:spree_blog, :name => "My blog #{i}") }
    end
    
    should "render 404 if blog is not found" do
      with_driver(:rack_test) do
        visit spree.blog_posts_path("does_not_exist")
        assert page.status_code == 404, "Expected response to be 404"
      end
    end

    should "render 404 if blog name is shorter than 3 characters" do
      Factory.create(:spree_blog, :name => "abc")

      with_driver(:rack_test) do
        visit spree.blog_posts_path("a")
        assert page.status_code == 404, "Expected response to be 404"

        visit spree.blog_posts_path("ab")
        assert page.status_code == 404, "Expected response to be 404"

        visit spree.blog_posts_path("abc")
        assert page.status_code == 200, "Expected response to be 200"
      end
    end
    
  end

end
