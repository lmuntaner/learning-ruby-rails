# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  lyrics     :text
#  bonus      :string(255)      not null
#

class Track < ActiveRecord::Base
  BONUSES = %w(bonus regular)
  validates :album, :name, :bonus, presence: true
  validates :bonus, inclusion: { in: BONUSES }
  
  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes, dependent: :destroy
end
