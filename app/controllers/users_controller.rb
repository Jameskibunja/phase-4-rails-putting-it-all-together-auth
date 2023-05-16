class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create]
  
    def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user
      else
        render json: { errors: ["Not Authorized"] }, status: :unauthorized
      end
    end
  
    def destroy
      session.delete :user_id
      head :no_content
    end
  end
  
  class UsersController < ApplicationController
    skip_before_action :authorize, only: [:create]
  
    def create
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: {
          errors: user.errors.full_messages
        },
               status: :unprocessable_entity
      end
    end
  
    def show
      user = User.find_by(id: session[:user_id])
      if user
        render json: user, status: :ok
      else
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(
        :username,
        :password,
        :password_confirmation,
        :image_url,
        :bio
      )
    end
  end