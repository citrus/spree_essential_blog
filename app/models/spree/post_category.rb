class Spree::PostCategory < ActiveRecord::Base
  
  attr_accessible :name, :permalink
  
  validates :name, :presence => true
  validates :permalink,  :presence => true, :uniqueness => true, :if => proc{ |record| !record.name.blank? }
  
  has_and_belongs_to_many :posts, :join_table => 'spree_post_categories_posts', :uniq => true
  
  before_validation :create_permalink
  
  def to_param
    permalink
  end
  
  private
  
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
      post_category = Spree::PostCategory.find_by_permalink(new_permalink)
      post_category != nil && !(post_category == self)
    end
    
end
