# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: "Signed Up Successfully.",
          data: resource
        }
      }, status: :ok
    else
      render json: {
        status: {
          message: "User could not be created successfully.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  rescue ActionController::ParameterMissing
    render json: { status: 400, message: "Invalid parameters. Expected 'user' object." }, status: :bad_request
  end
  
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end