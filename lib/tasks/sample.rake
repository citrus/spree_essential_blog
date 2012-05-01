namespace :db do
  namespace :sample do
    desc "creates sample blog posts"
    task :blog do
      
      require 'ffaker'
      require Rails.root.join('config/environment.rb')
        
      image_dir = File.expand_path("../sample", __FILE__)
      images    = Dir[image_dir + "/*.jpg"]
      
      unless Spree::Blog.count == 0
        require 'highline/import'
        continue = ask("Sample data will destroy existing data. Continue? [y/n]")
        exit unless continue =~ /y/i
        Spree::Blog.destroy_all
      end
      
      product_ids = Spree::Product.select('id').all.collect(&:id) rescue []
      
      %w(Blog News).each do |name|
        
        print "Creating `#{name}`... "
        @blog = Spree::Blog.create(:name => name)
        puts "done."
        
        puts "Writing posts...\n"
        
        20.times { |i|
        
          post = @blog.posts.create(
            :title     => Faker::Lorem.sentence,
            :posted_at => Time.now - i * rand(10000000),
            :body      => Faker::Lorem.paragraph,
            :tag_list  => Faker::Lorem.words(rand(10)).join(", ")
          )
          
          rand(5).times { |i|
            image = post.images.create(:attachment => File.open(images.sort_by{rand}.first), :alt => Faker::Lorem.sentence)
          }
          
          unless product_ids.empty?
            rand(5).times { |i|
              post.post_products.create(:product_id => product_ids.sort_by{rand}.first, :position => i)
            }
          end
          
          print "*"
          
        }
        
        puts " done."
        
      end
        
      puts "\ndone."
      
    end
  end
end
