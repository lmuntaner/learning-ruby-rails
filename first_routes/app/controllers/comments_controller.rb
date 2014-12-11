class CommentsController < ApplicationController
  def index
    puts "hello! #{request.path}"
    path = request.path
    table_name = path.match('\/\w+\/').to_s[1..-2]
    puts "hello this is the table #{table_name}"
    type = table_name.singularize
    key = "#{type}_id".to_sym
    model_class = type.camelcase
    @comments = Comment.where(commentable_id: params[key], commentable_type: model_class)
    render json: @comments
  end
end
