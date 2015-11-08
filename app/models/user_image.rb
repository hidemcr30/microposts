class UserImage < ActiveRecord::Base
  belongs_to :user
  
  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif", "image/png" => "png" }
  
  def extension
    IMAGE_TYPES[content_type]
  end
  
  
  def uploaded_image=(image)
    self.content_type = convert_content_type(image.content_type)
    self.data = image.read
    @uploaded_image = image
  end
  
  def change
    create_table :user_images do |t|
      t.references :user, null: false
      t.binary :data, limit: 3.megabytes
      t.string :content_type
      t.timestamp null: false
    end
    
    add_index :user_images, :user_id
  end
  
  validate :check_image

  private
  def check_image
    if @uploaded_image
      if data.size > 3.megabytes
        errors.add(:uploaded_image, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(content_type)
        errors.add(:uploaded_image, :invaild_image)
      end
    end
  end

  
  def convert_content_type(ctype)
    ctype = ctype.rstrip.downcase
    case ctype
      when "image/pjpeg" then "image/jpeg"
      when "image/jpg" then "image/jpeg"
      when "image/x-png" then "image/png"
      else ctype
    end
  end
end
