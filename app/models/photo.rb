class Photo < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :photo_content_type, :photo_file_name, :photo_file_size, :photo
  
  before_save :grab_geotag
  
  has_attached_file :photo, :styles => { :thumb => "100x100>" }
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
