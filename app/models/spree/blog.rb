class Spree::Blog < ActiveRecord::Base
  
  has_many :posts, :class_name => "Spree::Post"
  
  validates :name, :permalink, :presence => true
  
end
