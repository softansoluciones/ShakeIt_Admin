
function validarLogin() {
  var vd = ValidarCamposData('log');

  if (vd == true) {
    login();
  } else {
    $.notify(vd, {
      animate: {
        enter: 'animated fadeInRight',
        exit: 'animated fadeOutRight',
        position: 'absolute'
      }
    });
  }

}

function login() {
  server();
}

function server() {

  var doc = $('#user').val();
  var pass = $('#pass').val();
  if (doc == pass) {
    var passc = pass;
  } else {
    var passc = hex_md5(pass);
  }

  var bdatos = {
    "documento_usuario": doc,
    "password_usuario": passc
  };
  $.ajax({
    type: 'POST',
    url: 'Api/v1/Usuarios.php/login',
    data: bdatos,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        if (response.Respuesta[0].doc_usuario == response.Respuesta[0].pass_usuario) {
          $('#user_modal_content').load("usuariosinfo.html");
          show_Usuario(response.Respuesta[0].id_usuario);
          $('#user_modal_log').modal({
            backdrop: 'static',
            keyboard: true,
            show: true
          })
        } else if (response.Respuesta[0].estado_usuario == 2) {
          $("#btns").html("<center><input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/></center>");
          $("#msg").html("<center><p>Usuario inactivo</p></center>");
          $("#modal_msg").modal('show');
          $("#ingresar").show();
          $("#ingresando").hide();
        } else if (response.Respuesta[0].tipo_usuario == 1) {
          $("#btns").html("<center><input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/></center>");
          $("#msg").html("<center><p>Usuario no autorizado</p></center>");
          $("#modal_msg").modal('show');
          $("#ingresar").show();
          $("#ingresando").hide();
        } else {
          var idus = response.Respuesta[0].id_usuario;
          var nomus = response.Respuesta[0].nom_usuario;
          var apeus = response.Respuesta[0].ape_usuario;
          var tipus = response.Respuesta[0].tipo_usuario;
          var nomtipus = response.Respuesta[0].nom_tipo;
          sesionUs(idus, nomus, apeus, tipus, nomtipus);
        }
      } else {
        //alert("Error de autenticación.")
        $("#btns").html("<center><input data-dismiss='modal' aria-label='Close' class='btn btn_sh_normal m-r-1em' value='Aceptar'/></center>");
        $("#msg").html("<center><p>Error de autenticación.</p></center>");
        $("#modal_msg").modal('show');
        $("#ingresar").show();
        $("#ingresando").hide();
      }
    },
    beforeSend: function() {
      $("#ingresar").hide();
      $("#ingresando").show();
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#ingresar").show();
    $("#ingresando").hide();
  });

}

function sesionUs(idus, nomus, apeus, tipus, nomtipus) {
  sessionStorage.setItem("ses_estado", "ShakeItAdmin");
  sessionStorage.setItem("id_user", idus);
  localStorage.setItem("id_user", idus);
  sessionStorage.setItem("nom_user", nomus + " " + apeus);
  sessionStorage.setItem("tipo_user", tipus);
  sessionStorage.setItem("nomtipo_user", nomtipus);
  window.location = 'principal.html';
}

function ActualizarPagina() {
  location.reload(true);
}

function pc() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i))
  {
  } else
  {
      window.location = '../ShakeIt_Admin/index';
  }

}

function movil() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i))
  {
    window.location = '../ShakeIt_Admin/indexM';
  }
}


$(document).ready(function() {

  verificacionL();
  $("#ingresar").click(function() {
    validarLogin();
  });
  $('body').keyup(function(e) {
    if (e.keyCode == 13) {
      validarLogin();
    }
  })
});
