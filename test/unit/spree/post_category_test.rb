require 'test_helper'

class Spree::PostCategoryTest < ActiveSupport::TestCase

  def setup
    Spree::PostCategory.destroy_all
  end
  
  subject { Spree::PostCategory.new }
  
  should have_and_belong_to_many(:posts)
  should validate_presence_of(:name)
  
  should "automatically set permalink" do
    @category = Factory.create(:spree_post_category, :name => "This should parameterize")
    assert_equal "this-should-parameterize", @category.permalink
  end
  
  should "not duplicate path" do
    @category1 = Factory.create(:spree_post_category)
    @category2 = Factory.create(:spree_post_category)
    assert @category1.permalink != @category2.permalink
  end
   
end
