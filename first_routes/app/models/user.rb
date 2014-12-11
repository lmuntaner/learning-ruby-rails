# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  
  has_many :contacts, dependent: :destroy
  
  has_many(
    :sharings,
    class_name: "ContactShare",
    foreign_key: :user_id,
    dependent: :destroy
  )
  
  has_many(
    :shared_contacts,
    through: :sharings,
    source: :contact,
  )
  
  has_many :comments, as: :commentable
  
  has_many :groups
end
