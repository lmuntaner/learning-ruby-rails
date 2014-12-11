class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  
  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visit_records,
    class_name: "Visit",
    foreign_key: :visitor_id,
    primary_key: :id
  )
  
  has_many(
    :visited_urls,
    Proc.new { distinct },
    through: :visit_records,
    source: :visited_url
  )
end