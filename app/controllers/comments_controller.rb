class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @post = @comment.post

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render "posts/show" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end