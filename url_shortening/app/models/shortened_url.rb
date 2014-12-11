class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :long_url, presence: true, length: { maximum: 255 }
  validates :submitter, presence: true
  validate :no_more_than_five_submissions_per_min_per_user
  
  belongs_to(
    :submitter,
    :class_name => "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )
    
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :visited_url_id,
    primary_key: :id
  )
  
  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )
  
  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tagged_url_id,
    primary_key: :id
  )
  
  has_many(
    :tags,
    through: :taggings,
    source: :tagged_topic
  )
    
  def self.random_code
    while true
      short_url = SecureRandom.urlsafe_base64
      break unless self.exists?(:short_url => short_url)
    end
    short_url
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    short_url = self.random_code
    submitter_id = user.id
    options = { submitter_id: submitter_id, long_url: long_url, 
                short_url: short_url }
    self.create!(options)
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visitors.count
  end
  
  def num_recent_uniques
    visits
      .select("DISTINCT visitor_id")
      .where(created_at: 10.minutes.ago..Time.now)
      .count
  end
  
  private
  def no_more_than_five_submissions_per_min_per_user
    user = User.find(submitter_id)
    last_minute_submissions = user
        .submitted_urls
        .where(created_at: 1.minutes.ago..Time.now)
        .count
    if last_minute_submissions >= 5
      errors[:submit_frequency] << "can't submit more than five per minute!!"
    end
  end
end