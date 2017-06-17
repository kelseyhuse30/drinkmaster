class CommentsController < ApplicationController
	def index
		if params[:cocktail_id]
      @comments = Cocktail.find(params[:cocktail_id]).comments
    else
      @comments = Comment.all
    end

    render json: @comments
	end

	def create
		@comment = Comment.create(comment_params)
    render json: @comment
	end

	private

	def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end

end