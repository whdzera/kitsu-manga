class ProfileCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @profile_user = User.find(params[:profile_comment][:profile_user_id])
    @comment =
      @profile_user.profile_comments.build(
        body: params[:profile_comment][:body],
        user: current_user
      )

    if @comment.save
      redirect_to user_profile_path(@profile_user.username),
                  notice: "Comment Successfully posted."
    else
      redirect_to user_profile_path(@profile_user.username),
                  notice: "Comment could not be posted."
    end
  end

  def destroy
    @comment = ProfileComment.find(params[:id])

    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_back fallback_location: root_path, notice: "Comment deleted."
    else
      redirect_back fallback_location: root_path, alert: "Not authorized."
    end
  end
end
