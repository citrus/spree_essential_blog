FactoryGirl.define do

  factory :spree_blog, :class => Spree::Blog do
    name "Blog"
  end
  
  factory :spree_post, :class => Spree::Post do
    blog      { Spree::Blog.first || Factory(:spree_blog) }
    title     "Peanut Butter Jelly Time"
    posted_at { Time.now + rand(10000) }
    body      "Vivamus rutrum nunc non neque consectetur quis placerat neque lobortis. Nam vestibulum, arcu sodales feugiat consectetur, nisl orci bibendum elit, eu euismod magna sapien ut nibh. Donec semper quam scelerisque tortor dictum gravida. In hac habitasse platea dictumst. Nam pulvinar, odio sed rhoncus suscipit, sem diam ultrices mauris, eu consequat purus metus eu velit. Proin metus odio, aliquam eget molestie nec, gravida ut sapien. Phasellus quis est sed turpis sollicitudin venenatis sed eu odio. Praesent eget neque eu eros interdum malesuada non vel leo. Sed fringilla porta ligula egestas tincidunt. Nullam risus magna, ornare vitae varius eget, scelerisque a libero."
    tag_list  "peanut butter, jelly, sandwich, lunch"
    live      true
  end
  
  factory :spree_post_category, :class => Spree::PostCategory do
    name  "Jellies"
  end
  
  factory :spree_post_image, :class => Spree::PostImage do
    viewable { Spree::Post.first }
    attachment { sample_image }
  end

end
