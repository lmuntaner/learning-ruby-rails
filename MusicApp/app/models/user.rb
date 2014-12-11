# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, 
            :activation_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :session_token, :activation_token, uniqueness: true
  
  after_initialize :ensure_session_token
  
  has_many :notes, dependent: :destroy
  
  attr_reader :password
  
  def self.find_by_credentials(email, password)
    @user = User.find_by_email(email)
    return nil if @user.nil?
    return @user if @user.is_password?(password)
    nil
  end
  
  def generate_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token!
    self.session_token = generate_token
    self.save
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= generate_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def set_activation_token
    self.activation_token = generate_token
  end
  
  def activated?
    activated
  end
  
  def activate!
    self.toggle(:activated)
    save
  end
  
  def is_admin?
    admin
  end
end
