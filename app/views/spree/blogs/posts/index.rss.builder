xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@blog.name} - #{Spree::Config[:site_name]}"
    xml.description "#{@blog.name} - #{Spree::Config[:site_url]}"
    xml.link blog_posts_url(@blog)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post_rss(post)
        xml.pubDate post.posted_at.to_s(:rfc822)
        xml.link post_seo_path(@blog, post)
      end
    end
  end
end