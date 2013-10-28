class Tag < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_and_belongs_to_many :posts
  
  before_save :generate_slug
  private
  def generate_slug
    self.slug = self.name.gsub(/[^a-z0-9]/i, "")
  end
end
