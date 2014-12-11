class VotesController < ApplicationController

	def upvote
		@vote = Vote.new(vote_params(1))
    @post = get_post
		@vote.save
		redirect_to post_url(@post)
	end

	def downvote
		@vote = Vote.new(vote_params(-1))
    @post = get_post
		@vote.save
		redirect_to post_url(@post)
	end

	private

	def get_type
		path = request.path
    table_name = path.match('\/\w+\/').to_s[1..-2]
    type = table_name.singularize
    key = "#{type}_id".to_sym
    type.camelcase
  end
  
  def get_post
    @vote.votable.class == Post ? @vote.votable : @vote.votable.post
  end

  def vote_params(value)
  	{ value: value,
			votable_type: get_type, 
			votable_id: params[:id] }
  end
end
