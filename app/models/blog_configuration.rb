class BlogConfiguration < Configuration

  def self.current
    self.create if self.count == 0
    self.first
  end
  
  preference :disqus_shortname,  :string, :default => ''
  
end
