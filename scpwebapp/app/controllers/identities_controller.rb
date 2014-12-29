class IdentitiesController < ApplicationController
   skip_before_action :verify_authenticity_token
  include ApplicationHelper
  before_action :is_user_validated

  def new
    @identity = env['omniauth.identity']
  end
  
  
end
