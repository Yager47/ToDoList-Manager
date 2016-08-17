class Api::CommentsController < ApplicationController

  def index
    render json: task.comments
  end

  def create
    # comment = task.comments.create!(comment_params)
    comment = task.comments.new(comment_params)
    comment.attach = params[:file]
    comment.save
    render json: comment, status: 201
  end

  def update
    comment.update_attributes(comment_params)
    render nothing: true, status: 204
  end

  def destroy
    comment.destroy
    render nothing: true, status: 204
  end

  private
    def task
      @task ||= Task.find(params[:task_id])
    end

    def comment
      @comment ||= task.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text, :attach)
    end
end