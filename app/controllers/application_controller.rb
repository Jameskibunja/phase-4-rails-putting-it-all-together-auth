class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorize

  private

  def authorize
    unless session.include? :user_id
      return render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end
end