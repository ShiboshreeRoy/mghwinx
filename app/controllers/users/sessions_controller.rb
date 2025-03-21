# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    render json: {
      status: {
        code: 200,
        message: "User Signed in Successfully",
        data: current_user
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    token = request.headers['Authorization']&.split(' ')&.last

    if token.blank?
      render json: { status: 401, message: "Token is missing" }, status: :unauthorized
      return
    end

    begin
      jwt_payload = JWT.decode(
        token,
        Rails.application.credentials.fetch(:secret_key_base),
        true,
        algorithm: 'HS256'
      ).first

      user = User.find_by(id: jwt_payload['sub'])

      if user
        render json: { status: 200, message: "Signed Out Successfully" }, status: :ok
      else
        render json: { status: 401, message: "Invalid token" }, status: :unauthorized
      end
    rescue JWT::DecodeError => e
      render json: { status: 401, message: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end
end