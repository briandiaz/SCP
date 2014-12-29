module ModelsHelper
  include ApplicationHelper
  include AjaxHelper
  
  def get_model_image(model)
    search_google_image_by(model.brand.name + " " + model.name + " png")
  end
  def create_model(params)
    object = Model.new
    object.name = params[:model_name]
    object.brand_id = params[:model_brand_id]
    respond_to_json(object)
  end
end
