# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  include Votable
  
  validates :title, :author, presence: true
  
  has_many :post_subs, dependent: :destroy
  
  has_many :topics, through: :post_subs, source: :topic
  
  has_many :comments, dependent: :destroy

  # has_many :votes, as: :votable
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :top_level_comments,
    -> { where(parent_comment_id: nil) },
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )
  #
  # def vote_count
  #   self.votes.sum(:value)
  # end
  
  def show_comments
    top_level_comments    
  end
end
