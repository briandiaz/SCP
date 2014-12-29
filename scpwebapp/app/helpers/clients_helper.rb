module ClientsHelper
  include AjaxHelper
  
  def create_client(params)
    object = Client.new
    object.person_id = params[:client_person_id]
    respond_to_json(object)
  end
end
