#! /usr/bin/env ruby
# encoding: UTF-8

require_relative '../test_helper'

class Blog::PostCategoryIntegrationTest < ActiveSupport::IntegrationCase
  
  include Blog::PostsHelper
  
  def setup
    Post.destroy_all
    11.times{ |i| Factory.create(:post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) }
  end
    
  should "get the blog page" do
    visit posts_path
    # first post
    assert_seen "Categories", :within => ".post-sidebar .post-categories"
  end
    
end
