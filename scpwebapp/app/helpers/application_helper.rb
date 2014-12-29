require 'rubygems'
require 'json'
require 'rest-client' 
require 'uri'

module ApplicationHelper

  def is_user_validated
    redirect_to login_path if !current_user #!admin_user && !technician_user && 
  end
  
  def admin_user_permission
    redirect_to_back if !admin_user
  end
  
  def user_has_permission
    redirect_to_back if (!admin_user && !technician_user)
  end

  def redirect_to_back
      redirect_to :back
        rescue ActionController::RedirectBackError
          redirect_to :root
  end
  
  def google_images_api_search(search_query)
    url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+URI.escape(search_query)
    json_data = JSON.parse(RestClient.get(url))
    (json_data["responseStatus"].to_i == 200) ? json_data["responseData"]["results"] : nil
  end

  def search_google_image_by(search_query)
    images = google_images_api_search(search_query)
    (images) ? images[0]["url"] : "http://icons.iconarchive.com/icons/aha-soft/transport/256/car-icon.png"
  end

  def go_back_button(link)
    link_to link, :class=>"btn btn-lg btn-link", :style => "color:white" do
      glyph(:chevron_left)
    end
  end

  def profile_pic(person)
    image_tag person.photo_url(:medium).to_s
  end
  
  def remote_photo(person)
    image_tag person.remote_photo
  end

  def profile_pic(width,height)
    if current_user
      if current_user.person.remote_photo
        "<img src=\"#{current_user.person.remote_photo}\" alt=\"My account image remote\" data-src=\"#{current_user.person.remote_photo}\" data-src-retina=\"#{current_user.person.remote_photo}\" width=\"#{width}\" height=\"#{height}\">".html_safe 
      else
        "<img src=\"#{current_user.person.photo_url(:medium).to_s}\" alt=\"My account image url\" data-src=\"#{current_user.person.photo_url(:medium).to_s}\" data-src-retina=\"#{current_user.person.photo_url(:medium).to_s}\" width=\"#{width}\" height=\"#{height}\">".html_safe 
      end
    end
  end

  def profile_name(person)
    "#{person.first_name} #{person.last_name}" if person
  end

  def profile_name_current_user
    "#{current_user.person.first_name} <span class='semi-bold'>#{current_user.person.last_name}</span>".html_safe if current_user
  end

  def person_credentials(person)
    profile_name(person) + " (#{person.identification_card})"
  end

  def go_back_link(link)
    content_for :go_back_link, link.to_s
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def sub_title(page_sub_title)
    content_for :sub_title, page_sub_title.to_s
  end

  def icon_title(icon)
    content_for :icon_title, "fa fa-" + icon.to_s
  end

  def create_action(object)
    respond_to do |format|
      if object.save
        format_created(object,format)
      else
        format_unprocessable_entity(object,format)
      end
    end 
  end

  def update_action(object,params)
    respond_to do |format|
      if object.update(params)
        format_created(object,format)
      else
        format_unprocessable_entity(object,format)
      end
    end
  end

  def destroy_action(object,redirect)
    object.destroy
    respond_to do |format|
      format.html { redirect_to redirect }
      format.json { head :no_content }
    end
  end

  def format_unprocessable_entity(object,format)
    format.html { render action: 'new' }
    format.json { render json: object.errors, status: :unprocessable_entity }
  end

  def format_created(object,format)
    format.html { redirect_to object, notice: object.class.name + t("form.messages.successfully_created") }
    format.json { render action: 'show', status: :created, location: object }
  end
    
  def is_page_active(controller)
    if controller == "pages"
      "active" if current_page?(:controller => controller, :action => 'home')
    else
      "active" if current_page?(:controller => controller, :action => 'index') || 
                  current_page?(:controller => controller, :action => 'new')
    end
  end

    def vehicle_select_option_html(data: [], name: "", id: "", css_class: "", required: false)
    required = (required == true) ? 'required="required"' : ""
    html = '<select class="#{css_class}" id="#{id}" name="#{name}" #{required}>'
      html += "<option value="">Select the Vehicle</option>"
    data.each do |item|
      html += '<option value="'+item.id.to_s+'">'+item.brand.name+' - '+item.model.name+' ('+item.year.to_s+')</option>'
    end
    html += "</select>"
  end


end