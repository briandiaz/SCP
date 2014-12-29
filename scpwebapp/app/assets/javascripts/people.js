$(document).ready(function(){

  
  $('#tab_user').addClass('disabled');

  $('#tab_user').click(function(event){
    if ($(this).hasClass('disabled')) {
      return false;
    }
  });

  var register_user = $("#register_user_form").submit(function(e){
    e.preventDefault();
    var _username = $("#username").val();
    var _password = $("#password").val();
    var _register = "register_user";
    var _person_id =  $("#user_person_id").val();
    var _password_confirmation = $("#password_confirmation").val();
    var _auth = $('input[name=authenticity_token]').val()
    var _provider = "identity";
    var _utf8 = $("input[name=utf8]").val()
    var csrf_token = $("input[name=authenticity_token]").val();
    $.ajax({
      type: "POST",
      url: '/auth/identity/register',
      data: {
        register: _register,
        person_id: _person_id,
        username: _username,
        password: _password,
        password_confirmation: _password_confirmation,
        authenticity_token: _auth,
        provider: _provider,
        utf8: _utf8,
        _csrf_token: csrf_token
      },
      dataType: "json",
      statusCode: {
        200: function(data) {
          $("#success_registration_message_text").html("Cuenta del usuario <b>" + _username + "</b> ha sido creada satisfactoriamente!<br/>");
          $(".success_registration_message").show("slow").delay(5000).hide();
          $("#register_user_form input[type=submit]").remove();
          $("#username").attr("disabled","disabled");
          $("#password").attr("disabled","disabled");
          $("#password_confirmation").attr("disabled","disabled");

          $("form#register_user_form :input").each(function(){
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
    })

  });


  
  $("#register_person_form").submit(function(e){
    e.preventDefault();
    var person_first_name = $("#person_first_name").val();
    var person_last_name = $("#person_last_name").val();
    var person_identification_card = $("#person_identification_card").val();
    var person_sex = $('input[name=person_sex]:checked').val();
    var person_email = $('#person_email').val();
    var person_phone = $('#person_phone').val();
    var person_mobile = $('#person_mobile').val();
    var person_photo;
    console.log('http://api.randomuser.me/?gender='+person_sex.toLowerCase()+'&results=1');
    $.ajax({
      url: 'http://api.randomuser.me/?gender='+person_sex+'&results=1',
      dataType: 'json',
      async: false,
      success: function(data){
        person_photo = data.results[0].user.picture.large;
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
          $("#success_registration_message_text").html("Cuenta personal de <b>" + person_first_name + " "+person_last_name+"</b> ha sido creada satisfactoriamente!<br/>");
          $(".success_registration_message").show("slow");

          $("form#register_person_form :input").each(function(){
            var input = $(this); // This is the jquery object of the input, do what you will
            input.attr("disabled","disabled");
          });

          $("#register_person_form input[type=submit]").remove();

          $("#user_person_id").val(data["id"]);
          console.log(data["id"]);
          console.log(data);

          $("#tab1").removeClass("active");
          $("#tab2").addClass("active");

          $("#tab_personal").removeClass("active");
          $("#tab_user").removeClass("disabled");
          $("#tab_user").addClass("active");
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
    })

  });

})