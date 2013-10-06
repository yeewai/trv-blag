class Photo < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :photo_content_type, :photo_file_name, :photo_file_size, :photo
  
  #after_save :grab_geotag
  
  has_attached_file :photo, :styles => { :thumb => "100x100>" }, :path=> ':rails_root/public/system/:class/:style/:id-:filename', :url=> '/system/:class/:style/:id-:filename'
  validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  
  def self.img_tag 
    {
      'Photo' => [
        /\[photo(:.*)?\](.*?)\[\/photo\1?\]/mi,
        lambda{ |e| "<img src='#{Photo.find(e[2]).photo.url}' />" },
        'Photo from ID',
        '[photo]\1[/photo]',
        :photo
      ]
    }
  end
  
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
