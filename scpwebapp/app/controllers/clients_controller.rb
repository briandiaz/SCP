class ClientsController < ApplicationController
  include ApplicationHelper
  include ClientsHelper
  include VehiclesHelper
  before_action :set_client, only: [:show, :edit, :update, :destroy, :new_vehicle]
  before_action :is_user_validated
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]

  def index
    @clients = Client.find(:all, :order => "id asc", :include => :person)
  end

  def new_vehicle
    @vehicle = Vehicle.new
    @vehicle.owner_id = @client.id
  end
  
  def show
    @vehicles = Vehicle.where(owner_id: @client.id)
  end

  def new
    @client = Client.new
  end

  def newpersonclient
    @person = Person.new
  end
  
  def edit
  end


  def create
    if params[:is_ajax]
      create_client(params)
    else
      @client = Client.new(client_params)
      create_action(@client)
    end
  end

  def update
    update_action(@client,client_params)
  end

  def destroy
    destroy_action(@client,clients_path)
  end
  
  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:person_id)
    end
end
