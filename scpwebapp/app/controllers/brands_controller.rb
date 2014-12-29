class BrandsController < ApplicationController
  include ApplicationHelper
  include BrandsHelper
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]
  
  
  def index
    @brands = Brand.all(:include => :models)
  end

  def show
    @brand_image = get_brand_image(@brand)
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def create
    if params[:is_ajax]
      create_brand(params)
    else
      @brand = Brand.new(brand_params)
      create_action(@brand)
    end
  end

  def update
    update_action(@brand,brand_params)
  end

  def destroy
    destroy_action(@brand,brands_path)
  end
  
  private
    
    def set_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:name)
    end
end
