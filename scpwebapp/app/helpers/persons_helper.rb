module PersonsHelper
  include AjaxHelper
  
  def create_person(object,params,redirect)
    object = Person.new
    object.first_name = params[:first_name]  
    object.last_name = params[:last_name]  
    object.sex = params[:sex]  
    object.email = params[:email]                           
    object.phone = params[:phone]  
    object.mobile = params[:mobile]  
    object.identification_card = params[:identification_card]  
    object.remote_photo = params[:photo]
    respond_to_json(object)
  end

  def update_person(object,params,redirect)

    if object.update(params)
      redirect_to redirect
    end
  end

end

