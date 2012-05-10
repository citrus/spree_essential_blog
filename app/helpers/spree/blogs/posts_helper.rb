module Spree::Blogs::PostsHelper

  def post_seo_path(blog, post)
    spree.full_post_path(blog, post.year, post.month, post.day, post.to_param)
  end

  def post_seo_url(blog, post)
    spree.full_post_url(blog, post.year, post.month, post.day, post.to_param)
  end

  def post_rss(post)
    output = []
    post.images.each do |image|
      output << image_tag(image.attachment.url, :alt => image.alt)
    end
    output << post.rendered_body
    output.join("\n").html_safe
  end

end
