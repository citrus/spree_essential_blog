class PostCategory < ActiveRecord::Base
  
  validates :name, :presence => true
  validates :permalink,  :presence => true, :uniqueness => true, :if => proc{ |record| !record.name.blank? }
  
  has_and_belongs_to_many :posts
  
  before_validation :create_permalink
  
  def to_param
    permalink
  end
  
private

  def render(val)
    val = val.is_a?(Symbol) ? send(val) : val
    RDiscount.new(val).to_html.html_safe
  end

  def create_permalink
    count = 2
    new_permalink = name.to_s.parameterize
    exists = permalink_exists?(new_permalink)
    while exists do
      dupe_permalink = "#{new_permalink}_#{count}"
      exists = permalink_exists?(dupe_permalink)
      count += 1
    end
    self.permalink = dupe_permalink || new_permalink
  end

  def permalink_exists?(new_permalink)
    post_category = PostCategory.find_by_permalink(new_permalink)
    same_post = post_category == self
    return (post_category != nil && !same_post)
  end
  
end