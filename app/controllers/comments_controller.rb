class CommentsController < ApplicationController
	def index
		if params[:cocktail_id]
      @comments = Cocktail.find(params[:cocktail_id]).comments
    else
      @comments = Comment.all
    end

    render json: @comments
	end
end
