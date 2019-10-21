class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  # skip_before_action :verify_authenticity_token, if: :json_request?
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token
  before_action :set_current_user, if: :json_request?

  respond_to :json

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
        errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors,
                code: '100'
            }
        ]
    }, status: :bad_request
  end

  private
  def json_request?
    request.format.json?
  end
  # Use api_user Devise scope for JSON access
  # def authenticate_user!(*args)
  #   super and return unless args.blank?
  # end

  def invalid_auth_token
    respond_to do |format|
      format.html { redirect_to sign_in_path,
                                error: 'Login invalid or expired' }
      format.json { head 401 }
    end
  end
  # So we can use Pundit policies for api_users
  def set_current_user
    @current_user ||= warden.authenticate(scope: :api_user)
  end
end