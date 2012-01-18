require 'test_helper'

class Spree::PostTest < Test::Unit::TestCase

  def setup
    Spree::Post.destroy_all
  end
  
  subject { Spree::Post.new }
  
  should validate_presence_of(:title)
  should validate_presence_of(:body)
  
  should "automatically set path" do
    @post = Factory.create(:post, :title => "This should parameterize")
    assert_equal "this-should-parameterize", @post.path
  end
  
  should "validate date time" do
    @post = Factory.build(:post)
    @post.posted_at = "testing"
    assert !@post.valid?
  end
  
  should "parse date time" do
    date = DateTime.parse("2011/4/1 16:15")
    @post = Factory.build(:post)
    @post.posted_at = "april 1 2011 - 4:15 pm"
    assert @post.valid?
    assert_equal date, @post.posted_at
  end
  
end
