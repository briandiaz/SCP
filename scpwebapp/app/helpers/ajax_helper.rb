module AjaxHelper
  
  def respond_to_json(object)
    respond_to do |format|
      if object.save
        format.json { render :json => object}
      end
    end 
  end
  
end
