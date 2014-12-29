jQuery -> 

  vehicle_model = $("#visitor_vehicle_model_id").html()
  $("#visitor_vehicle_model_id").attr('disabled','disabled')
  $("#visitor_vehicle_model_id").addClass("form-control")
    
  $('#visitor_vehicle_brand_id').change ->
    vehicle_brand = $('#visitor_vehicle_brand_id :selected').text()
    escaped_brand = vehicle_brand.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    
    options_model = $(vehicle_model).filter("optgroup[label='#{escaped_brand}']").html()
    
    if options_model
      $("#visitor_vehicle_model_id").removeAttr('disabled')
      $('#visitor_vehicle_model_id').html(options_model)
    else
      $('#visitor_vehicle_model_id').empty()
      $("#visitor_vehicle_model_id").attr('disabled','disabled')