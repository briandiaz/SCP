class RolesController < ApplicationController
  include ApplicationHelper
  #include Errors::RescueError
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  before_action :admin_user_permission, only: [:edit, :update, :new, :destroy]

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    create_action(@role)
  end

  def update
    update_action(@role,role_params)
  end

  def destroy
    destroy_action(@role,roles_path)
  end
  
  private
    
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :value)
    end
end
