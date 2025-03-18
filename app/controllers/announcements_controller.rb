class AnnouncementsController < ApplicationController
  before_action :require_admin, only: [:update]

  def update
    @announcement = Announcement.first
    if @announcement.update(announcement_params)
      redirect_to root_path, notice: "Announcement updated successfully."
    else
      redirect_to root_path, alert: "Failed to update announcement."
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:content)
  end

  def require_admin
    redirect_to root_path, alert: "You are not authorized to edit announcements" unless current_user&.admin?
  end
end
