class Spree::Blog < ActiveRecord::Base
  
  has_many :posts, :class_name => "Spree::Post"
  
  validates :title, :path, :presence => true
  
end
