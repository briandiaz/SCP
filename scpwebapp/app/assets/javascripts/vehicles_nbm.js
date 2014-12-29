$(document).ready(function(){
  var is_ajax = true;
  var _ctk = $("meta[name=csrf-token]"); 
  var _cp = $("meta[name=csrf-param]"); 
  var _atk = _ctk.attr("content");
  
  
  $("#new_brand_vehicles").submit(function(e){
    e.preventDefault();
    var brand_name = $("#brand_name").val();
    $.ajax({
      type: "POST",
      url: '/brands',
      data: { 
        is_ajax: is_ajax,
        brand_name: brand_name,
        _csrf_param: _cp.attr("content"),
        _csrf_token: _ctk.attr("content"),
        authenticity_token: _atk
      },
      dataType: "json",
      statusCode: {
        200: function(data) {
          $("#success_registration_message_text_brands").html("Marca <b>" + data["name"] +"</b> ha sido registrada satisfactoriamente!<br/>");
          $(".success_registration_message_brands").show("slow");
          console.log(data);
          $("form#new_brand_vehicles :input").each(function(){
            var input = $(this); // This is the jquery object of the input, do what you will
            input.attr("disabled","disabled");
          });
          $("#new_vehicle #vehicle_brand_id").append($("<option />").val(data["id"]).text(data["name"]));
          $("#new_vehicle #vehicle_brand_id").val(data["id"]);

        },
        500: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_brands").html("Error! (" + textStatus + ": 500): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_brands").show("slow");
        },
        402: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_brands").html("Error! (" + textStatus + ": 402): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_brands").show("slow");
        },
        400: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_brands").html("Error! (" + textStatus + ": 400): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_brands").show("slow");
        },
        406: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_brands").html("Error! (" + textStatus + ": 406): <br/>" + errorThrown + "<br/> Ya ha sido registrado una marca con estos datos" );
          $(".error_registration_message_brands").show("slow");
        }
      }
    });
  });

  $("#new_model_vehicles").submit(function(e){
    e.preventDefault();
    var model_brand_id = $("#model_brand_id").val();
    var model_name = $("#model_name").val();
    var model_brand_name = $("#model_brand_id option:selected").text();
    $.ajax({
      type: "POST",
      url: '/models',
      data: { 
        is_ajax: is_ajax,
        model_brand_id: model_brand_id,
        model_name: model_name,
        _csrf_param: _cp.attr("content"),
        _csrf_token: _ctk.attr("content"),
        authenticity_token: _atk
      },
      dataType: "json",
      statusCode: {
        200: function(data) {
          $("#success_registration_message_text_models").html("Modelo <b>" + data["name"] +"</b> ha sido registrada satisfactoriamente!<br/>");
          $(".success_registration_message_models").show("slow");

          $("form#new_model_vehicles :input").each(function(){
            var input = $(this); // This is the jquery object of the input, do what you will
            input.attr("disabled","disabled");
          });
          $("#vehicle_model_id").removeAttr('disabled');
          $("#new_vehicle #vehicle_brand_id").append($("<option />").val(data["brand_id"]).text(model_brand_name));
          $("#new_vehicle #vehicle_brand_id").val(data["brand_id"]);
          
          $("#new_vehicle #vehicle_model_id").append($("<option />").val(data["id"]).text(data["name"]));
          $("#new_vehicle #vehicle_model_id").val(data["id"]);
        },
        500: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_models").html("Error! (" + textStatus + ": 500): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_models").show("slow");
        },
        402: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_models").html("Error! (" + textStatus + ": 402): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_models").show("slow");
        },
        400: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_models").html("Error! (" + textStatus + ": 400): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message_models").show("slow");
        },
        406: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text_models").html("Error! (" + textStatus + ": 406): <br/>" + errorThrown + "<br/> Ya ha sido registrado un model con estos datos" );
          $(".error_registration_message_models").show("slow");
        }
      }
    });
  });
});