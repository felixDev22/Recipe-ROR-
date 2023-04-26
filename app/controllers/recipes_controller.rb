class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.where(user: current_user)
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_url, notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preperation_time, :cooking_time, :description, :public)
  end
end