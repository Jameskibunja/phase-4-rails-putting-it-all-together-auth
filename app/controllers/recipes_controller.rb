class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_recipe
    wrap_parameters format: []
  
    def index
      render json: Recipe.all, status: :ok
    end
  
    def create
      user = User.find_by(id: session[:user_id])
      recipe = user.recipes.create!(recipe_params)
      render json: recipe, status: :created
    end
  
    private
  
    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end
  
    def invalid_recipe(invalid)
      render json: {
        errors: invalid.record.errors.full_messages
      },
             status: :unprocessable_entity
    end
  end