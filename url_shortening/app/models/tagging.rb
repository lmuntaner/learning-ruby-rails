class Tagging < ActiveRecord::Base
  validates :tagged_url, presence: true
  validates :tagged_topic, presence: true
  
  belongs_to(
    :tagged_url,
    class_name: "ShortenedUrl",
    foreign_key: :tagged_url_id,
    primary_key: :id
  )
  
  belongs_to(
    :tagged_topic,
    class_name: "TagTopic",
    foreign_key: :tagged_topic_id,
    primary_key: :id
  )
end