var userltip = parseInt(sessionStorage.getItem("tipo_user"))
var GlobalUserid = parseInt(sessionStorage.getItem("id_user"))
var Globalmodulo = sessionStorage.getItem("modulo");
var Gustoken = sessionStorage.getItem("token");

function user_data() {

  $("#nom_us").html(sessionStorage.getItem("nom_user"))
  $("#car_us").html(sessionStorage.getItem("nomtipo_user"))
  menuXUsuario();
}

function get_modulo() {
  verificacionI();
  var modulo = sessionStorage.getItem("modulo");

  switch (modulo) {
    case "1":
      Vista_Reportes()
      break;
    case "1.2":
      Vista_Ventas()
      break;
    case "2":
      Vista_Inventario()
      break;
    case "3":
      Vista_Insumos();
      break;
    case "4":
      Vista_Productos()
      break;
    case "4.2":
      Vista_ProductosReg()
      break;
    case "5":
      Vista_Usuarios()
      break;
    case "6":
      Vista_UsuarioInfo()
      break;
    case "7":
      Vista_Sedes()
      break;
    case "8":
      Vista_Recursos()
      break;
    case "9":
      Vista_Alertas()
      break;
    case "10":
      Vista_Parametrizador()
      break;
    default:
      if (userltip == 4) {
        Vista_Inventario()
      } else {
        Vista_Reportes()
      }
  }

}

function Vista_Reportes() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("reportes.html");
  sessionStorage.setItem("modulo", 1);
  removeActive();
  hideSubmenu();
  $('#mod_1').addClass('active_nav');
  $('#mod_1_1').addClass('active_nav');
  $('#subMod_1').show('fast');
}

function Vista_Ventas() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("ventas.html");
  sessionStorage.setItem("modulo", 1.2);
  removeActive();
  hideSubmenu();
  $('#mod_1').addClass('active_nav');
  $('#mod_1_2').addClass('active_nav');
  $('#subMod_1').show('fast');
}

function Vista_Inventario() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("inventario.html");
  sessionStorage.setItem("modulo", 2);
  removeActive();
  hideSubmenu();
  $('#mod_2').addClass('active_nav');
}

function Vista_Insumos() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("insumos.html");
  sessionStorage.setItem("modulo", 3);
  removeActive();
  hideSubmenu();
  $('#mod_3').addClass('active_nav');
}

function Vista_Productos() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("productosList.html");
  sessionStorage.setItem("modulo", 4);
  removeActive();
  hideSubmenu();
  $('#mod_4').addClass('active_nav');
  $('#mod_4_1').addClass('active_nav');
  $('#subMod_4').show('fast');
}

function Vista_ProductosReg() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("productosReg.html");
  sessionStorage.setItem("modulo", 4.2);
  removeActive();
  hideSubmenu();
  $('#mod_4').addClass('active_nav');
  $('#mod_4_2').addClass('active_nav');
  $('#subMod_4').show('fast');
}

function Vista_Usuarios() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("usuarios.html");
  sessionStorage.setItem("modulo", 5);
  removeActive();
  hideSubmenu();
  $('#mod_5').addClass('active_nav');
}

function Vista_UsuarioInfo() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("usuariosinfo.html");
  sessionStorage.setItem("modulo", 6);
  removeActive();
  hideSubmenu();
  $('#mod_6').addClass('active_nav2');
}

function Vista_Sedes() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("sedes.html");
  sessionStorage.setItem("modulo", 7);
  removeActive();
  hideSubmenu();
  $('#mod_7').addClass('active_nav');
}

function Vista_Recursos() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("recursos.html");
  sessionStorage.setItem("modulo", 8);
  removeActive();
  hideSubmenu();
  $('#mod_8').addClass('active_nav');
}

function Vista_Alertas() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("alertas.html");
  sessionStorage.setItem("modulo", 9);
  removeActive();
  hideSubmenu();
  $('#mod_9').addClass('active_nav');
}

function Vista_Parametrizador() {
  Get_UsuarioMod()
  user_data()
  $("#L_contenido").load("parametrizador.html");
  sessionStorage.setItem("modulo", 10);
  removeActive();
  hideSubmenu();
  $('#mod_10').addClass('active_nav');
}

function ActualizarPagina() {
  location.reload(true);
}

function menuXUsuario() {
  $("a[name ='menup']").each(function () {

    var usertype = $(this).data("usertype");
    if (userltip == 4 && usertype != 2) {
      $(this).hide();
    }
  });

}

function removeActive() {

  $(".active_nav").each(function () {
    $(this).removeClass("active_nav");
  });

  $(".active_nav2").each(function () {
    $(this).removeClass("active_nav2");
  });

}

function hideSubmenu() {
  $("div[name ='sub_menu']").each(function () {
    $(this).hide("fast");
  });

}

function menuPan() {

  //alert($("#menupan").position().left);
  //alert($(window).width());

  var panpos = $(window).width();
  if ($("#menupan").position().left >= panpos) {
    $("#menupan").animate({
      left: '0%'
    });
    $("body").addClass('overbody');
  } else {
    $("#menupan").animate({
      left: '100%'
    });
    $("body").removeClass('overbody');

  }

}

function pc() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {} else {
    window.location = '../ShakeIt_Admin/inicio';
  }

}

function movil() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
    window.location = '../ShakeIt_Admin/inicioM';
  }
}

function redireccionLogin() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
    window.location = '../ShakeIt_Admin/loginM';
  } else {
    window.location = '../ShakeIt_Admin/login';
  }

}

function redireccionInicio() {

  var device = navigator.userAgent

  if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
    window.location = '../ShakeIt_Admin/inicioM';
  } else {
    window.location = '../ShakeIt_Admin/inicio';
  }

}

$(document).ready(function () {
  Create_TokenUser(GlobalUserid);
  verificacionI();
  user_data();
  get_modulo();
  setInterval(get_Cantidad, 10000);
  Notification.requestPermission();
});