class Spree::Blog < ActiveRecord::Base
  
  has_many :posts, :class_name => "Spree::Post", :dependent => :destroy
  
  validates :name, :presence => true
  validates :permalink, :uniqueness => true, :format => { :with => /^[a-z0-9\-\_\/]+$/i }, :length => { :within => 3..40 }
  
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

  def normalize_permalink
    self.permalink = (permalink.blank? ? name.to_s.parameterize : permalink).downcase.gsub(/(^[\/\-\_]+)|([\/\-\_]+$)/, "")
  end
  
end
