class Api::V1::PlatesController < Api::V1::ApiController
before_action :set_plate, only: [:show, :update, :destroy]

def index
  @plates = Plate.all
  render json: @plates
end

def show
  render json: @plate
end

def create
  @plate = Plate.create(plate_params)
  render json: @plate
end

def update
  if @plate.update(plate_params)
    render json: @plate
  end
end

def destroy
  @plate.destroy
  render json: {message: 'ok'}
end

private

  def set_plate
    @plate = Plate.find(params[:id])
  end

  def plate_params
    params.require(:plate).permit(:name, :description, :price, :restaurant_id)
  end
end