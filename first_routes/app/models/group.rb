class Group < ActiveRecord::Base
  validates :name, :user_id, presence: true
  
  belongs_to :user
  has_many :group_contacts
  has_many :contacts, through: :group_contacts, source: :contact
end
