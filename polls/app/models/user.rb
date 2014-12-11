class User < ActiveRecord::Base
  validates :user_name, presence: true
  
  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def completed_polls
    #returns all the polls where the user has answered all of the questions
    # Poll.find_by_sql(
    # [
    #   "
    #   SELECT
    #     polls.*
    #   FROM
    #     polls
    #   JOIN
    #     questions ON polls.id = questions.poll_id
    #   LEFT OUTER JOIN
    #     (
    #       SELECT
    #         answer_choices.question_id as question_id,
    #         responses.id as response_id
    #       FROM
    #         answer_choices
    #       JOIN
    #         responses ON answer_choices.id = responses.answer_choice_id
    #       WHERE
    #         user_id = ?
    #     ) AS ans_questions ON ans_questions.question_id = questions.id
    #   GROUP BY
    #     polls.id
    #   HAVING
    #     COUNT(*) = SUM(CASE WHEN ans_questions.response_id IS NULL THEN 0 ELSE 1 END)
    #   ",
    #   self.id
    # ]
    # )
    
    Poll
        .select('polls.*')
        .joins("JOIN questions ON questions.poll_id = polls.id")
        .joins("
              LEFT OUTER JOIN
              (
                SELECT
                  answer_choices.question_id as question_id,
                  responses.id as response_id
                FROM
                  answer_choices
                JOIN
                  responses ON answer_choices.id = responses.answer_choice_id
                WHERE
                  user_id = #{self.id}
                ) AS ans_questions ON ans_questions.question_id = questions.id"
              )
        .group('polls.id')
        .having('COUNT(*) = COUNT(ans_questions.response_id)')
        
        # SUM(CASE WHEN ans_questions.response_id IS NULL THEN 0 ELSE 1 END)
    
  end
  
  
end