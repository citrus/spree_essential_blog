class Spree::PostProduct < ActiveRecord::Base

  attr_accessible :post_id, :product_id, :position
  
  belongs_to :post
  belongs_to :product

  validates_associated :post
  validates_associated :product

end
