$(document).ready(function(){
  var _ctk = $("meta[name=csrf-token]"); 
  var _cp = $("meta[name=csrf-param]"); 
  var _atk = _ctk.attr("content");

  function register_client(person){
    var is_ajax = true;
    $.ajax({
      type: "POST",
      url: '/clients',
      data: { 
        is_ajax: is_ajax,
        client_person_id: person["id"],
        _csrf_param: _cp.attr("content"),
        _csrf_token: _ctk.attr("content"),
        authenticity_token: _atk
      },
      dataType: "json",
      statusCode: {
        200: function(data) {
          $("#success_registration_message_text").html("Nuevo cliente <b>" + person["first_name"] + " "+person["last_name"]+"</b> ha sido registrado satisfactoriamente!<br/>");
          console.log(data);
          window.location.href = "http://scpweb.herokuapp.com/client/new_vehicle/" + data.id + "";
          $(".success_registration_message").show("slow");
          $("form#register_person_client_form :input").each(function(){
            var input = $(this); // This is the jquery object of the input, do what you will
            input.attr("disabled","disabled");
          });

        },
        500: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 500): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        402: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 402): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        400: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 400): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        406: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 406): <br/>" + errorThrown + "<br/> Ya ha sido registrado una persona con algunos de estos datos" );
          $(".error_registration_message").show("slow");
        }
      }
    });
  }
  
  function register_person(){
    var person_first_name = $("#person_first_name").val();
    var person_last_name = $("#person_last_name").val();
    var person_photo = "";
    var person_identification_card = $("#person_identification_card").val();
    var person_sex = $('input[name=person_sex]:checked').val();
    var person_email = $('#person_email').val();
    var person_phone = $('#person_phone').val();
    var person_mobile = $('#person_mobile').val();
    var json_url = 'http://api.randomuser.me/?gender='+person_sex.toLowerCase()+'&results=1';
    console.log(json_url);
    $.ajax({
      url: json_url,
      dataType: 'json',
      async: false,
      success: function(data){
        person_photo = data.results[0].user.picture.large;
        console.log(data.results[0].user.picture.large);
      }
    });
    $.ajax({
      type: "POST",
      url: '/people',
      data: { 
        first_name: person_first_name,
        last_name: person_last_name,
        photo: person_photo,
        identification_card: person_identification_card,
        sex: person_sex,
        email: person_email,
        phone: person_phone,
        mobile: person_mobile
      },
      dataType: "json",
      statusCode: {
        200: function(data) {
          $("#success_registration_message_text").html("Cuenta personal de <b>" + person_first_name + " "+person_last_name+"</b> ha sido creada satisfactoriamente!<br/>")
          $(".success_registration_message").show("slow");

          $("#register_person_client_form input[type=submit]").remove();

          $("#person_id").val(data["id"]);
          console.log(data);

          register_client(data);

        },
        500: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 500): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        402: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 402): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        400: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 400): <br/>" + errorThrown + "<br/>" + xhr);
          $(".error_registration_message").show("slow");
        },
        406: function(xhr, textStatus, errorThrown) {
          $("#error_registration_message_text").html("Error! (" + textStatus + ": 406): <br/>" + errorThrown + "<br/> Ya ha sido registrado una persona con algunos de estos datos" );
          $(".error_registration_message").show("slow");
        }
      }
    });
  }
  
  $("#register_person_client_form").submit(function(e){
    e.preventDefault();
    register_person();
  });


});