require 'test_helper'

class Spree::BlogTest < Test::Unit::TestCase

  def setup
    Spree::Blog.destroy_all
  end
  
  subject { Spree::Blog.new }
  
  should validate_presence_of(:title)
  should validate_presence_of(:path)
  
  should have_many(:posts)
  
end
