# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#  votable_id   :integer
#  votable_type :string(255)
#

class Vote < ActiveRecord::Base
	validates :value, :votable_type, :votable_id, presence: true

	belongs_to :votable, polymorphic: true
  
end
