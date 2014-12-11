# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do

User.create!(:user_name => 'Llorenc')
User.create!(:user_name => 'Coulter')

Poll.create!(:author_id => 1, :title => 'Barcelona vs. Real Madrid')
Poll.create!(:author_id => 2, :title => 'App Academy vs. Dev Bootcamp')

Question.create!(:poll_id => 1, :question_text => 'Who will win?')
Question.create!(:poll_id => 1, :question_text => 'Who will score first?')
Question.create!(:poll_id => 2, :question_text => 'Who will win?')
Question.create!(:poll_id => 2, :question_text => 'Who will make more money?')

AnswerChoice.create!(:question_id => 1, :answer_text => 'Barcelona')
AnswerChoice.create!(:question_id => 1, :answer_text => 'Real Madrid')
AnswerChoice.create!(:question_id => 2, :answer_text => 'Messi')
AnswerChoice.create!(:question_id => 2, :answer_text => 'Ronaldo')
AnswerChoice.create!(:question_id => 3, :answer_text => 'App Academy')
AnswerChoice.create!(:question_id => 3, :answer_text => 'Dev Bootcamp')
AnswerChoice.create!(:question_id => 4, :answer_text => 'Llorenc')
AnswerChoice.create!(:question_id => 4, :answer_text => 'Coulter')

end
