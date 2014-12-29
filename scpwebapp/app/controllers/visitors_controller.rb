class VisitorsController < ApplicationController
  include ApplicationHelper
  include AjaxHelper
  before_action :set_visitor, only: [:show, :edit, :update, :destroy]
  before_action :set_vehicle_visits, only: [:index, :create, :new, :edit, :update, :destroy]

  def index
    @visitors = Visitor.all
  end
  
  def show
  end

  def new
    @visitor = Visitor.new
  end

  def edit
  end

  def create
    if params[:is_ajax]
      create_visitor(params)
    else
      @visitor = Visitor.new(visitor_params)
      create_action(@visitor)
    end
  end

  def update
    update_action(@visitor,visitor_params)
  end

  def destroy
    destroy_action(@visitor,visitors_path)
  end
  
  private
    def set_vehicle_visits
      @vehicles_visit = Vehicle.where(owner_id: 15)
    end
    def set_visitor
      @visitor = Visitor.find(params[:id])
    end

    def visitor_params
      params.require(:visitor).permit(:person_id, :vehicle_id, :expiring_time, :notes)
    end

    def create_visitor(params)
      object = Visitor.new
      object.person_id = params[:visitor_person_id]
      object.vehicle_id = params[:visitor_vehicle_id]
      object.expiring_time = params[:visitor_expiring_time]
      object.notes = params[:visitor_notes]
      respond_to_json(object)
    end
end
