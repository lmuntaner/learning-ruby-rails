# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
  :comments,
  class_name: "Comment",
  foreign_key: :author_id,
  primary_key: :id,
  dependent: :destroy
  )
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    return user if user.is_password?(password)
    nil
  end
  
  def generate_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def ensure_session_token
    self.session_token ||= generate_token
  end
  
  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end
  
end
