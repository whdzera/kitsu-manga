class Api::BaseController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :authenticate_user!

  private
end
