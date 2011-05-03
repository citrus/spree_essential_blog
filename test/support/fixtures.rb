FactoryGirl.define do

  factory :page do
    title            "Just a page"
    #nav_title        { title }
    #path             { "/" + title.parameterize }
    meta_title       { nav_title }
    meta_description { "Nothing too cool here except the title: #{title}." } 
    meta_keywords    { "just, something, in, a, list, #{title.downcase}" }
  end

  factory :post do
    title     "Peanut Butter Jelly Time"
    path      { title.parameterize }
    posted_at { Time.now + rand(10000) }
    body      "Vivamus rutrum nunc non neque consectetur quis placerat neque lobortis. Nam vestibulum, arcu sodales feugiat consectetur, nisl orci bibendum elit, eu euismod magna sapien ut nibh. Donec semper quam scelerisque tortor dictum gravida. In hac habitasse platea dictumst. Nam pulvinar, odio sed rhoncus suscipit, sem diam ultrices mauris, eu consequat purus metus eu velit. Proin metus odio, aliquam eget molestie nec, gravida ut sapien. Phasellus quis est sed turpis sollicitudin venenatis sed eu odio. Praesent eget neque eu eros interdum malesuada non vel leo. Sed fringilla porta ligula egestas tincidunt. Nullam risus magna, ornare vitae varius eget, scelerisque a libero."
    tag_list  "peanut butter, jelly, sandwich, lunch"
  end

end