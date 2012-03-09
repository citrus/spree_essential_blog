class Spree::Blog < ActiveRecord::Base
  
  has_many :posts, :class_name => "Spree::Post"
  
  validates :name, :presence => true
  validates :permalink, :uniqueness => true, :format => { :with => /^[a-z0-9\-\_\/]+$/i }, :length => { :within => 2..40 }
  
  before_validation :normalize_permalink
  
private

  def normalize_permalink
    self.permalink = (permalink.blank? ? name.to_s.parameterize : permalink).downcase.gsub(/(^[\-\_]+)|([\/\-\_]+$)/, "").sub(/^\/*/, "/")
  end
  
end
