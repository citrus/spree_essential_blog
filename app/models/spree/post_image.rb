class Spree::PostImage < Spree::Asset

  validate :no_attachement_errors

  has_attached_file :attachment,
    :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium,
    :url => '/spree/posts/:id/:style/:basename.:extension',
    :path => ':rails_root/public/spree/posts/:id/:style/:basename.:extension'

  def image_content?
    attachment_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end
  
  def attachment_sizes
    hash = {}
    hash.merge!(:mini => '48x48>', :small => '150x150>', :medium => '600x600>', :large => '950x700>') if image_content?
    hash
  end
  
  def no_attachement_errors
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
    
end
