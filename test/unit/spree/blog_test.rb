require 'test_helper'

class Spree::BlogTest < ActiveSupport::TestCase

  setup do
    Spree::Blog.destroy_all
  end
  
  subject do
    Spree::Blog.new(:name => "OMG!")
  end
  
  should have_many(:posts)
  should have_many(:categories).through(:posts)
  
  should validate_presence_of(:name)
  should ensure_length_of(:permalink).is_at_least(3).is_at_most(40)
                
  [ "no spaces", "Chars!!", "-", "_", "/" ].each do |val|
    should_not allow_value(val).for(:permalink)
  end
  
  [ "dash-es", "under_scores", "CAPS", "CamelCase", "/perma/link/" ].each do |val|
    should allow_value(val).for(:permalink)
  end

  should "automatically set permalink" do
    @blog = Factory.create(:spree_blog, :name => "This should parameterize", :permalink => "")
    assert_equal "this-should-parameterize", @blog.permalink
  end
  
  should "normalize permalink" do
    @blog = Factory.create(:spree_blog, :name => "This should parameterize", :permalink => "//omG-PERMA-link__-/")
    assert_equal "omg-perma-link", @blog.permalink
  end
      
  context "an existing blog" do
    
    setup do
      @blog = Factory(:spree_blog)
    end
    
    should validate_uniqueness_of(:permalink)
    
    should "find by permalink" do
      assert_equal @blog, Spree::Blog.find_by_permalink(@blog.permalink)
    end
    
    should "find by permalink when double slashes are present" do
      assert_equal @blog, Spree::Blog.find_by_permalink("/" + @blog.permalink)
    end
    
    should "find by permalink when trailing slashes are present" do
      assert_equal @blog, Spree::Blog.find_by_permalink(@blog.permalink + "/")
    end
    
  end

end
