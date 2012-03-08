class Spree::Blog < ActiveRecord::Base
  
  alias_attribute :name, :title
  
  has_many :posts, :class_name => "Spree::Post"
  
  validates :title, :path, :presence => true
  
end
