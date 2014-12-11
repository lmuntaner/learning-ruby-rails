# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  band_id     :integer          not null
#  name        :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#  recorded_at :string(255)      not null
#

class Album < ActiveRecord::Base
  LOCATIONS = %w(studio live)
  validates :name, :band, :recorded_at, presence: true
  validates :recorded_at, inclusion: { in: LOCATIONS }
  
  has_many :tracks, dependent: :destroy
  
  belongs_to :band
end
