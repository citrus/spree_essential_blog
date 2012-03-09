require 'test_helper'

class Spree::PostImageTest < ActiveSupport::TestCase
   
  setup do
    @post_image = Spree::PostImage.new
  end

  should belong_to(:viewable)
  should validate_attachment_presence(:attachment)
  
  %w(image/jpeg image/gif image/png image/tiff).each do |mime|  
    should "return true for #{mime} as image content" do
      @post_image.attachment_content_type = mime
      assert @post_image.image_content?
    end
  end
  
  %w(application/pdf text/css).each do |mime|  
    should "return false for #{mime} as image content" do
      @post_image.attachment_content_type = mime
      assert !@post_image.image_content?
    end
  end
  
  should "have blank attachment sizes hash if post is not image content" do
    hash = {}
    assert_equal hash, @post_image.attachment_sizes
  end
  
  %w(image/jpeg image/gif image/png image/tiff).each do |mime|  
    should "have attachment sizes hash for #{mime}" do
      @post_image.attachment_content_type = mime
      hash = { :mini => '48x48>', :small => '150x150>', :medium => '600x600>', :large => '950x700>' }
      assert_equal hash, @post_image.attachment_sizes
    end
  end
  
end
