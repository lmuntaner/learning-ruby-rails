class TagTopic < ActiveRecord::Base
  validates :tag_name, presence: true, uniqueness: true, length: { maximum: 255 }
  
  has_many(
    :link_tags,
    class_name: "Tagging",
    foreign_key: :tagged_topic_id,
    primary_key: :id
  )
  
  has_many(
    :tagged_urls,
    through: :link_tags,
    source: :tagged_url
  )
end