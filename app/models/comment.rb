class Comment < ActiveRecord::Base
  attr_accessible :content, :ip, :name, :post_id
  
  belongs_to :post
  
  validates :name, presence: true
  validates :content, presence: true
end
