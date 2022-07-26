class ToysController < ApplicationController
  wrap_parameters format: []

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update(toy_params)
    render json: toy
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private
 
  def find_toy
    Toy.find(params[:id])
  end 

  def render_not_found_response
    render json: { error: "Toy not found" }, status: :not_found
  end 

  def toy_params
    params.permit(:name, :image, :likes)
  end

end
