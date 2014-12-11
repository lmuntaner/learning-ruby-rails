# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string(255)      not null
#  name        :string(255)      not null
#  sex         :string(255)      not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  SEXES = ["M", "F"]
  COLORS = ["white","black", "grey", "brown", "orange"]
  
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: SEXES }
  validates :color, inclusion: { in: COLORS }
  validates_date :birth_date, :on_or_before => lambda { Date.current }
  
  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    dependent: :destroy
  )
  
  belongs_to(
   :owner,
   class_name: "User",
   foreign_key: :owner_id
  )
  
  def age
    (Date.current - birth_date).to_i / 365
  end
end
