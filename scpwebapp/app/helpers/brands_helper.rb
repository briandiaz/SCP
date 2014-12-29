module BrandsHelper
  include ApplicationHelper
  include AjaxHelper
  
  def get_brand_image(brand)
    search_google_image_by(brand.name + " logo png")
  end
  
  def create_brand(params)
    object = Brand.new
    object.name = params[:brand_name]
    respond_to_json(object)
  end
end
