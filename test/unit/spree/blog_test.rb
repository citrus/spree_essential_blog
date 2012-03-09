require 'test_helper'

class Spree::BlogTest < ActiveSupport::TestCase

  setup do
    Spree::Blog.destroy_all
  end
  
  subject do
    Spree::Blog.new(:name => "OMG!")
  end
  
  should have_many(:posts)
  should validate_presence_of(:name)
                
  [ "no spaces", "Chars!!", "-", "_", "/" ].each do |val|
    should_not allow_value(val).for(:permalink)
  end
  
  [ "dash-es", "under_scores", "CAPS", "CamelCase", "/perma/link/" ].each do |val|
    should allow_value(val).for(:permalink)
  end

  should "automatically set permalink" do
    @blog = Factory.create(:spree_blog, :name => "This should parameterize", :permalink => "")
    assert_equal "/this-should-parameterize", @blog.permalink
  end
  
  should "normalize permalink" do
    @blog = Factory.create(:spree_blog, :name => "This should parameterize", :permalink => "omG-PERMA-link__-/")
    assert_equal "/omg-perma-link", @blog.permalink
  end
   
  should "validate length of permalink when too short" do
    subject.permalink = "x"
    subject.valid?
    assert subject.errors.include?(:permalink)
  end
  
  should "validate length of permalink when too short" do
    subject.permalink = "x" * 40
    subject.valid?
    assert subject.errors.include?(:permalink)
  end
   
  context "an existing blog" do
    
    setup do
      Factory(:spree_blog)
    end
    
    should validate_uniqueness_of(:permalink)
  
  end

end
