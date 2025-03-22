# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :validate_sign_up_params, only: [:create]

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
          code: 422,
          message: "User could not be created.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def validate_sign_up_params
    return if params[:user].present?
    
    render json: {
      status: {
        code: 400,
        message: "Invalid parameters. Expected 'user' object."
      }
    }, status: :bad_request
  end
end