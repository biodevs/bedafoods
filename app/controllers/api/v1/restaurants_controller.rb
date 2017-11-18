class Api::V1::RestaurantsController < Api::V1::ApiController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all
    render json: @restaurants.to_json
  end

  def show
    render json: @restaurant, include: 'plates'
  end

  def update
    @restaurant.update(restaurant_params)
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    render json: @restaurant
  end

  def destroy
    @restaurant.destroy
    render json: {message: 'ok'}
  end

  private

    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:id])    
    end
    
    def restaurant_params
      params.require(:restaurant).permit(:name, :description)        
    end
end