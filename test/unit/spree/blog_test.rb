require 'test_helper'

class Spree::BlogTest < Test::Unit::TestCase

  def setup
    Spree::Blog.destroy_all
  end
  
  subject { Spree::Blog.new }
  
  should validate_presence_of(:name)
  should validate_presence_of(:permalink)
  
  should have_many(:posts)
  
end
