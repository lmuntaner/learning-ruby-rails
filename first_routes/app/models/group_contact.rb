class GroupContact < ActiveRecord::Base
  validates :contact, :group, presence: true
  
  belongs_to :contact
  belongs_to :group
end