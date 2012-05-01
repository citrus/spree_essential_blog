class Spree::Blog < ActiveRecord::Base
  
  attr_accessible :name, :permalink
  
  RESERVED_PATHS = /(^\/*(admin|account|cart|checkout|content|login|pg|orders|products|s|session|signup|shipments|states|t|tax_categories|user)\/+)/
  
  has_many :posts, :class_name => "Spree::Post", :dependent => :destroy
  has_many :categories, :through => :posts, :source => :post_categories, :uniq => true
  
  validates :name, :presence => true
  validates :permalink, :uniqueness => true, :format => { :with => /^[a-z0-9\-\_\/]+$/i }, :length => { :within => 3..40 }
  validate  :permalink_availablity
  
  before_validation :normalize_permalink
  
  def self.find_by_permalink!(path)
    super path.to_s.gsub(/(^\/+)|(\/+$)/, "")
  end

  def self.find_by_permalink(path)
    find_by_permalink!(path) rescue ActiveRecord::RecordNotFound
  end
  
  def self.to_options
    self.order(:name).map{|i| [ i.name, i.id ] }
  end
  
  def to_param
    self.permalink.gsub(/(^\/+)|(\/+$)/, "")
  end
  
private

  def permalink_availablity
    errors.add(:permalink, "is reserved, please try another.") if "/#{permalink}/" =~ RESERVED_PATHS
  end

  def normalize_permalink
    self.permalink = (permalink.blank? ? name.to_s.parameterize : permalink).downcase.gsub(/(^[\/\-\_]+)|([\/\-\_]+$)/, "")
  end
  
end
