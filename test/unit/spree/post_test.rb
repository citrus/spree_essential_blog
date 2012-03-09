require 'test_helper'

class Spree::PostTest < ActiveSupport::TestCase

  setup do
    Spree::Post.destroy_all
  end
  
  subject { Spree::Post.new }
  
  should validate_presence_of(:title)
  should validate_presence_of(:body)
  
  should belong_to(:blog)
  
  should "automatically set path" do
    @post = Factory.create(:spree_post, :title => "This should parameterize")
    assert_equal "this-should-parameterize", @post.path
  end
  
  should "increment path when it already exists" do
    @post = Factory.create(:spree_post, :title => "This should parameterize")
    @post2 = Factory.create(:spree_post, :title => "This should parameterize")
    assert_equal "this-should-parameterize-2", @post2.path
  end
  
  should "validate date time" do
    @post = Factory.build(:spree_post)
    @post.posted_at = "testing"
    assert !@post.valid?
  end
  
  should "parse date time" do
    date = DateTime.parse("2011/4/1 16:15")
    @post = Factory.build(:spree_post)
    @post.posted_at = "april 1 2011 - 4:15 pm"
    assert @post.valid?
    assert_equal date, @post.posted_at
  end
  
end
