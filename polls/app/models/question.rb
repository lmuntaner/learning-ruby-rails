class Question < ActiveRecord::Base
  validates :question_text, presence: true
  validates :poll, presence: true
  
  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    # result_hash = Hash.new(0)
    # responses.each do |response|
    #   result_hash[response.answer_choice.answer_text] += 1
    # end
    # result_hash
    
    # result_hash = Hash.new(0)
    # response_answers = responses.includes(:answer_choice)
    # response_answers.each do |response|
    #   result_hash[response.answer_choice.answer_text] += 1
    # end
    # result_hash
    
    # results = ActiveRecord::Base.connection.execute(<<-SQL, self.id)
   #      SELECT
   #        ac.answer_text AS answer, COUNT(*) AS num_answers
   #      FROM
   #        responses AS r
   #      RIGHT OUTER JOIN
   #        answer_choices AS ac ON r.answer_choice_id = ac.id
   #      WHERE
   #        ac.question_id = ?
   #      GROUP BY
   #        ac.id
   #  SQL
    
   results = self
              .answer_choices
              .select('answer_choices.answer_text AS answer,
                        SUM(CASE WHEN responses.id IS NULL THEN 0 ELSE 1 END) AS num_answers')
              .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id')
              .group('answer_choices.id')
    
    result_hash = Hash.new(0)
    results.each { |result| result_hash[result.answer] = result.num_answers }
    result_hash

  end

end