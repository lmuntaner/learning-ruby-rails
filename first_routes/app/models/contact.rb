# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates :name, :user_id, :email, presence: true
  validates :email, :uniqueness => {:scope => :user_id} 
  
  belongs_to( 
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :contact_shareds,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    dependent: :destroy
  )
  
  has_many(
    :shared_users,
    through: :contact_shareds,
    source: :user
  )
  
  has_many :comments, as: :commentable
  
  has_many :group_contacts
  
  has_many :groups, through: :group_contacts, source: :group 
  
  def favorite
    self.favorite = true
  end
end
