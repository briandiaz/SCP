# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  
  vehicle_model = $("#vehicle_model_id").html()
  $("#vehicle_model_id").attr('disabled','disabled')
  $("#vehicle_model_id").addClass("form-control")
  

  
  $('#vehicle_brand_id').change ->
    vehicle_brand = $('#vehicle_brand_id :selected').text()
    escaped_brand = vehicle_brand.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    
    options_model = $(vehicle_model).filter("optgroup[label='#{escaped_brand}']").html()
    
    if options_model
      $("#vehicle_model_id").removeAttr('disabled')
      $('#vehicle_model_id').html(options_model)
    else
      $('#vehicle_model_id').empty()
      $("#vehicle_model_id").attr('disabled','disabled')