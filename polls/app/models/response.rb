class Response < ActiveRecord::Base
  validates :answer_choice, presence: true
  validates :respondent, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poll_author
  
  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  
  def sibling_responses
      question.responses.where('responses.id IS NOT NULL')
  end
  
  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:responses] << "You can't respond twice to the same question"
    end
  end
  
  def respondent_is_not_poll_author
    poll = Poll
              .select("polls.*")
              .joins("JOIN questions ON questions.poll_id = polls.id")
              .joins("JOIN answer_choices ON answer_choices.question_id = questions.id")
              .where("answer_choices.id = ?", self.answer_choice_id)
    if self.user_id == poll.first.author_id
      errors[:responses] << "You can't respond to your own question"
    end
  end
  
end
