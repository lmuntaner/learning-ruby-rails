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

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
