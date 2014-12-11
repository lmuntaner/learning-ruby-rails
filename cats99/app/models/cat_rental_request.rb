# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]
  
  after_initialize do
    self.status ||= "PENDING"
  end
  
  validates :cat, :start_date, :end_date, :status, :user, presence: true
  validates :status, inclusion: { in: STATUSES }
  
  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id
  )
  
  belongs_to :user
  
  def approve!
    return false if overlapping_approved_requests.count >= 1
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      save!
      
      # overlapping_pending_requests.update_all(status: "DENIED")
      
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end
  
  def deny!
    CatRentalRequest.transaction do
      self.status = "DENIED"
      save!
    end
  end
  
  def pending?
    status == "PENDING"
  end
  
  def overlapping_requests
    CatRentalRequest.where("
        id != #{self.id}
      AND
        cat_id = #{self.cat_id}
      AND
      ( 
        ( ? BETWEEN start_date AND end_date)
      OR
        ( ? BETWEEN start_date AND end_date)  
      )", start_date, end_date)
  end
  
  def overlapping_approved_requests
    overlapping_requests.select do |request|
      request.status == "APPROVED"
    end
  end
  
  def overlapping_pending_requests
    overlapping_requests.select do |request|
      request.status == "PENDING"
    end
  end
end
