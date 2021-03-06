class GaragesController < ApplicationController
  def index
    @garages = Garage.all
    @garage_order = Garage.order(:created_at)
  end

  def show
    @garage = Garage.find(params[:id])
    @motorcycle_count = @garage.count_motorcycles
  end

  def index_motorcycles_in_garage
    @motorcycles = Garage.find(params[:id]).motorcycles
  end

  def index_sorted_motorycles_in_garage
    if params[:model_year].nil?
      @motorcycles = Garage.find(params[:id]).motorcycles.order(:name)
    else
      form_argument = params[:model_year]
      @motorcycles = Garage.find(params[:id]).motorcycles.where("model_year > ?", form_argument)
    end
  end

  def new
  end

  def create
    garage = Garage.create(
      name: params[:name],
      at_capacity: params[:at_capacity],
      max_capacity: params[:max_capacity]
      )

    redirect_to '/garages'
  end

  def edit
    @garage = Garage.find(params[:id])
  end

  def update
    garage = Garage.find(params[:id])
    garage.update(
      name: params[:name],
      at_capacity: params[:at_capacity],
      max_capacity: params[:max_capacity]
      )
    garage.save
    redirect_to "/garages/#{garage.id}"
  end

  def destroy
    Garage.destroy(params[:id])
    redirect_to '/garages'
  end
end
