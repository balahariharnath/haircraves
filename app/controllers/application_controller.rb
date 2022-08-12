class ApplicationController < ActionController::Base
  # rescue_from Exception, :with => :error_generic
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    alert_msg = 'You are not authorized to make any changes with your user access. Contact your administrator to grant access to make any changes.'
    render :json => { :success => false, :unauthorized_access => alert_msg }, status: 401 if request.format == 'json'
  end

  def error_generic(exception)
    Rails.logger.info "error_generic"
    Rails.logger.info exception
    respond_to do |format|
      format.json { render json: {error: "Something went wrong. Please try again."}, :status => :unprocessable_entity }
    end
  end

  def set_current_user
    User.current_user = current_user
  end
end
