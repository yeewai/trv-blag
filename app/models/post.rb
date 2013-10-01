class Post < ActiveRecord::Base
  attr_accessible :address, :content, :latitude, :longitude, :slug, :title, :user_id
  belongs_to :user
  
  geocoded_by :address
  after_validation :geocode
  
  def to_param
    slug
  end
  
  before_save :generate_slug
  
  private
  def generate_slug
    self.slug = self.title.gsub(/[^a-z0-9]/i, "-")
  end
end
