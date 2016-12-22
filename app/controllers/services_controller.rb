class ServicesController < ApplicationController
  before_action :authenticate_user!, exception: [:show]
  before_action :set_service, only: [:show, :edit, :update]

  def index
    @services = current_user.services
  end

  def show
    @is_buyer = Order.where("service_id = ? AND user_id = ?", @service.id, current_user.id).present? if current_user
    @reviews = @service.reviews
    @reviewed = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
     @service = current_user.services.build
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      redirect_to @service
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service
    else
      render :edit
    end
  end

  def service_params
    params.require(:service).permit(:title, :description, :price, :requirements, :image, :category)
  end

  def set_service
    @service = Service.find(params[:id])
  end

end