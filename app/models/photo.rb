class Photo < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :photo_content_type, :photo_file_name, :photo_file_size, :photo
  
  #after_save :grab_geotag
  
  options = if Rails.env.production? 
    {:styles => { :thumb => "100x100>", :medium=>"600x400>" }, 
      :path=> ':rails_root/public/system/:class/:style/:id-:filename', 
      :url=> '/system/:class/:style/:id-:filename',
      :storage => :s3,
      :bucket => ENV['S3_BUCKET_NAME'],
      :s3_credentials => {
       :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
       :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
     }
  else
     {:styles => {:thumb => "100x100>", :medium=>"600x400>"} , 
       :path=> ':rails_root/public/system/:class/:style/:id-:filename', 
       :url=> '/system/:class/:style/:id-:filename'}  
  end
  
  has_attached_file :photo, options
  validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  
  
  private
  def grab_geotag
    if self.photo && (self.photo_content_type == 'image/jpeg' || self.photo_content_type == 'image/jpg')
      jpg = EXIFR::JPEG.new(self.photo.url)
      if jpg.gps?
        self.latitude = jpg.gps_lat
        self.longitude = jpg.gps_lng
      end
    end
  end
end
