class Spree::PostImage < Spree::Asset

  validate :no_attachement_errors

  has_attached_file :attachment,
    :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium
   
  def image_content?
    attachment_content_type.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end
  
  def has_alt?
    !self.alt.blank?
  end
     
  def attachment_sizes
    if image_content?
      { :mini => '48x48>', :small => '150x150>', :medium => '600x600>', :large => '950x700>' }
    else
      {}
    end
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
