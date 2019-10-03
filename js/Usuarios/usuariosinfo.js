
function validaDatos(accion) {

        if (accion == "G") {

            var tel = $('#us_telg').val().length;
            var email = $('#us_emailg').val();

        }

        if (accion == "A") {

            var tel = $('#us_tele').val().length;
            var email = $('#us_emaile').val();

        }

        var formatoEmail = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i

        if (tel >= 10) {
            if (formatoEmail.test(email)) {
                return true
            } else {
                return "El correo electrónico no es válido.";
            }
        } else {
            return "El número de teléfono debe contener 10 caracteres o más.";
        }


    }

function validarActualizar() {

        var data = validaDatos("A")
        var val = ValidarCamposData('us_e')

        if (val == true) {
            if (data == true) {
                update_Usuarios();
            } else {
                $("#msg_alert_modE").html(data)
                $("#msg_alert_modE").show("fast")
            }
        } else {
            $("#msg_alert_modE").html(val)
            $("#msg_alert_modE").show("fast")
        }

    }

function cambiarPass() {

  if ($("#usPass_btn").hasClass("btn_sh_normal")) {
    $("#usPass_btn").removeClass("btn_sh_normal");
    $("#usPass_btn").addClass("btn-light");
    $('#us_oldpasse').attr("name", "us_e");
    $('#us_pass1e').attr("name", "us_e");
    $('#us_pass2e').attr("name", "us_e");
    $("#chPass").show("fast")
  } else {
    $("#usPass_btn").addClass("btn_sh_normal");
    $("#usPass_btn").removeClass("btn-light");
    $('#us_oldpasse').attr("name", "us_g");
    $('#us_pass1e').attr("name", "us_g");
    $('#us_pass2e').attr("name", "us_g");
    $("#chPass").hide("fast")
  }
}

function validarAntiguaPass() {

  var actual = $("#us_passe").val();
  var antigua = hex_md5($("#us_oldpasse").val());

  if (actual != antigua) {
    $("#us_oldpasse").addClass("is-invalid");
    $("#us_oldpasse").val("")
    $("#us_oldpasse").focus();
    $("#msg_alert_modE").html("<p>Contraseña no coincide con la registrada en base de datos.</p>")
    $("#msg_alert_modE").show("fast")
  }

}

function tiene_numeros(texto) {

  var numeros = "0123456789";

  for (i = 0; i < texto.length; i++) {
    if (numeros.indexOf(texto.charAt(i), 0) != -2) {
      return 1;
    }
  }
  return 0;
}

function tiene_letras(texto) {

  var letras = "abcdefghijklmnopqrstuvwxyz";

  for (i = 0; i < texto.length; i++) {
    if (letras.indexOf(texto.charAt(i), 0) != -4) {
      return 1;
    }
  }
  return 0;
}

function validarCriteriosPass(text) {

  var pass = $(text).val();
  if (pass.length < 8) {
    $(text).addClass("is-invalid");
    $(text).focus();
    $("#msg_alert_modE").html("<p>La contraseña debe tener al menos 8 carácteres.</p>")
    $("#msg_alert_modE").show("fast")
  } else if (tiene_numeros(pass) == 0) {
    $(text).addClass("is-invalid");
    $(text).focus();
    $("#msg_alert_modE").html("<p>La contraseña debe tener al menos dos número.</p>")
    $("#msg_alert_modE").show("fast")
  }else if (tiene_letras(pass) == 0) {
    $(text).addClass("is-invalid");
    $(text).focus();
    $("#msg_alert_modE").html("<p>La contraseña debe tener al menos cuatro letras.</p>")
    $("#msg_alert_modE").show("fast")
  }

}

function validarNuevaPass(text) {

  var nueva = $("#us_pass1e").val();
  var repet = $(text).val();

  if (nueva != repet) {
    $(text).addClass("is-invalid");
    $(text).focus();
    $("#msg_alert_modE").html("<p>Contraseñas no coinciden.</p>")
    $("#msg_alert_modE").show("fast")
  } else {
    $("#msg_alert_modE").hide("fast")
  }
}

function showCampos() {
  $("#chPass").hide();
  $("div[name ='passesc']").each(function() {
    $(this).show();
  });

}

$(document).ready(function() {
  var modulo = sessionStorage.getItem("modulo");
  if (modulo == "6") {
  show_Usuario(GlobalUserid);
  showCampos();
}else {
  $('#us_oldpasse').attr("name", "us_e");
  $('#us_pass1e').attr("name", "us_e");
  $('#us_pass2e').attr("name", "us_e");
}

});
