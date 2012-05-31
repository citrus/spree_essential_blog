class Spree::Post < ActiveRecord::Base
  
  attr_accessible :blog_id, :title, :teaser, :body, :posted_at, :author, :live, :tag_list, :post_category_ids, :product_ids_string
  
  acts_as_taggable

  # for flash messages    
  alias_attribute :name, :title
  
  has_and_belongs_to_many :post_categories, :join_table => "spree_post_categories_posts", :class_name => "Spree::PostCategory"
  alias_attribute :categories, :post_categories
  
  belongs_to :blog, :class_name => "Spree::Blog"
  has_many :post_products, :dependent => :destroy
  has_many :products, :through => :post_products
  has_many :images, :as => :viewable, :class_name => "Spree::PostImage", :order => :position, :dependent => :destroy
  
  validates :blog_id, :title, :presence => true
  validates :path,  :presence => true, :uniqueness => true, :if => proc{ |record| !record.title.blank? }
  validates :body,  :presence => true
  validates :posted_at, :datetime => true
  
  cattr_reader :per_page
  @@per_page = 10

  scope :ordered, order("posted_at DESC")
  scope :future,  where("posted_at > ?", Time.now).order("posted_at ASC")
  scope :past,    where("posted_at <= ?", Time.now).ordered
  scope :live,    where(:live => true )

 	before_validation :create_path, :if => proc{ |record| record.title_changed? }
  
  
  # Creates date-part accessors for the posted_at timestamp for grouping purposes.
  %w(day month year).each do |method|
    define_method method do
      self.posted_at.send(method)
    end
  end
  	
	def rendered_preview
    preview = body.split("<!-- more -->")[0]
    render(preview)
  end
	
	def rendered_body
	  render(body.gsub("<!-- more -->", ""))
  end
		
	def preview_image
    images.first if has_images?	  
	end

  def has_images?
    images && !images.empty?
  end
  

  def live?
    live && live == true
  end

  def to_param
		path
	end
	
  def product_ids_string
    product_ids.join(',')
  end

  def product_ids_string=(s)
    self.product_ids = s.to_s.split(',').map(&:strip)
  end
  
	private
	
    def render(val)
      val = val.is_a?(Symbol) ? send(val) : val
      RDiscount.new(val).to_html.html_safe
    end
		
    def create_path
  		count = 2
  		new_path = title.to_s.parameterize
  		exists = path_exists?(new_path)
  		while exists do
  			dupe_path = "#{new_path}-#{count}"
  			exists = path_exists?(dupe_path)
  			count += 1
  		end
  		self.path = dupe_path || new_path
  	end
  	
  	def path_exists?(new_path)
  		post = Spree::Post.find_by_path(new_path)
  		post != nil && !(post == self)
  	end
	
end
