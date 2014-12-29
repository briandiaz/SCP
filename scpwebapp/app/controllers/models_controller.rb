class ModelsController < ApplicationController
  include ApplicationHelper
  include ModelsHelper
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]

  def index
    @models = Model.all
  end

  def show
    @model_image = get_model_image(@model)
  end

  def new
    @model = Model.new
  end

  def edit
  end

  def create
    if params[:is_ajax] 
      create_model(params)
    else
      @model = Model.new(model_params)
      create_action(@model)
    end
  end

  def update
    update_action(@model,model_params)
  end

  def destroy
    destroy_action(@model,models_path)
  end

  private
    def set_model
      @model = Model.find(params[:id])
    end

    def model_params
      params.require(:model).permit(:name, :brand_id)
    end
end
