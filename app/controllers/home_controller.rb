class HomeController < ApplicationController
  
  def index
    @announcement = Announcement.first
  end

end
