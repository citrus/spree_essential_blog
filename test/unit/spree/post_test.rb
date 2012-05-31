require 'test_helper'

class Spree::PostTest < ActiveSupport::TestCase

  setup do
    Spree::Post.destroy_all
  end
  
  def scope_includes(scope, post)
    Spree::Post.send(scope).all.map(&:id).include?(post.id)
  end
  
  subject { Spree::Post.new }
  
  should validate_presence_of(:title)
  should validate_presence_of(:body)
  
  should belong_to(:blog)
  should have_and_belong_to_many(:post_categories)
  should have_many(:post_products)
  should have_many(:products).through(:post_products)
  should have_many(:images)
  
  should "automatically set path" do
    @post = Factory.create(:spree_post, :title => "This should parameterize")
    assert_equal "this-should-parameterize", @post.path
  end
  
  should "increment path when it already exists" do
    @post = Factory.create(:spree_post, :title => "This should parameterize")
    @post2 = Factory.create(:spree_post, :title => "This should parameterize")
    assert_equal "this-should-parameterize-2", @post2.path
  end
  
  context "a new post" do
  
    setup do
      @post = Factory.build(:spree_post)
    end
  
    should "validate date time" do
      @post.posted_at = "testing"
      assert !@post.valid?
    end
    
    should "parse date time" do
      date = DateTime.parse("2011/4/1 16:15")
      @post.posted_at = "april 1 2011 - 4:15 pm"
      assert @post.valid?
      assert_equal date, @post.posted_at
    end
        
    context "with products" do
      
      setup do
        @product_ids = [ Factory.create(:product), Factory.create(:product) ].map(&:id)
      end
      
      should "set product ids string" do
        @post.product_ids_string = @product_ids.join(",")
        assert_equal @product_ids, @post.product_ids
      end
      
      should "get product ids string" do
        @post.product_ids = @product_ids
        assert_equal @product_ids.join(","), @post.product_ids_string
      end
    
    end
    
  end
  
  context "#scopes" do
  
    setup do
      @unpublished_post = Factory(:spree_post, :live => false)
      @future_post = Factory(:spree_post, :posted_at => Time.now + 1.hour)
      @past_post = Factory(:spree_post, :posted_at => Time.now - 1.hour)
    end
    
    should "have live scope" do
      assert scope_includes(:live, @future_post)
      assert scope_includes(:live, @past_post)
      assert !scope_includes(:live, @unpublished_post)
    end
    
    should "have future scope" do
      assert scope_includes(:future, @future_post)
      assert !scope_includes(:future, @past_post)
    end
    
    should "have past scope" do
      assert scope_includes(:past, @past_post)
      assert !scope_includes(:past, @future_post)
    end
        
    should "have ordered scope (posted_at DESC)" do
      posts = Spree::Post.ordered.all
      assert posts.index(@future_post) < posts.index(@past_post)
    end
    
  end

end
