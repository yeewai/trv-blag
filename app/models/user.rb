class User < ActiveRecord::Base
  attr_accessible :avatar_content_type, :avatar_file_name, :avatar_file_size, :name, :password_digest, :token, :avatar
  
  has_many :posts
  
  #Password Stuffs
  has_secure_password
  
  #Token to store in cookie
  before_create { generate_token(:token) }
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  has_attached_file :avatar
  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
end
