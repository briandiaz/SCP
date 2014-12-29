class PeopleController < ApplicationController
  include ApplicationHelper
  include PersonsHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  skip_before_action :verify_authenticity_token
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]

  def index
    @users = User.find(:all, :order => "id asc", :include => :person)
  end

  def account
    @identity = Identity.find(current_user.uid)
    @person = current_user.person
  end
  
  def show
    @vehicles = Vehicle.where(owner_id: @person.client.id) if @person.client
  end
  
  def new
    if admin_user
      @person = Person.new
      @identity = env['omniauth.identity']
    else
      redirect_to root_url
    end
  end

  def edit
  end

  def create
    create_person(@person,params,root_path)
  end

  def update
    update_person(@person,person_params,account_path)
  end

  def destroy
    destroy_action(@person,root_path)
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:first_name, :last_name, :sex, :email, :phone, :mobile, :identification_card, :photo)
    end
end
