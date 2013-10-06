class Post < ActiveRecord::Base
  attr_accessible :address, :content, :latitude, :longitude, :slug, :title, :user_id
  belongs_to :user
  
  geocoded_by :address
  after_validation :geocode
  acts_as_gmappable

  def gmaps4rails_address
    address
  end
  
  def to_param
    slug
  end
  
  def cutcontent
    content.gsub(/(\[cut\].+)/, "[url=/posts/#{self.slug}]Read more[/url]")
  end
  
  def self.bbtags 
    {
      'Photo' => [
        /\[photo(:.*)?\](.*?)\[\/photo\1?\]/mi,
        lambda{ |e| "<img src='#{Photo.find(e[2]).photo.url}' />" },
        'Photo from ID',
        '[photo]\1[/photo]',
        :photo
      ],
      'Cut' => [
        /\[cut(:.*)?\]/mi,
        '',
        'Add a cut to the post',
        '[cut]',
        :cut
      ]
    }
  end
  
  before_save :generate_slug
  
  private
  def generate_slug
    self.slug = self.title.gsub(/[^a-z0-9]/i, "-")
  end
end
