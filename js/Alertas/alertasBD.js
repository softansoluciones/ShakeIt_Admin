
function Load_Alertas() {

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Alertas.php/alertas/GlobalUserid',
    dataType: 'json',
    success: function (response) {
      if (response.Respuesta != 0) {
        $('#divCards').html('')
        $.each(response.Respuesta, function (i, item) {
          if (item.fk_estado == 1) {
            $('#divCards').append('<a class="card text-white bg-primary mb-3" href="javascript: show_Alerta(' + item.id_alerta + ')" style="max-width: 18rem;" id="alerta_' + item.id_alerta + '"> <div class="card-body">\n\
          <center>\n\
          <p class="card-text">'+ item.nom_alerta + '</p>\n\
          </center>\n\
          </div>\n\
          </a>');
          } else {
            $('#divCards').append('<a class="card bg-light mb-3" href="javascript: show_Alerta(' + item.id_alerta + ')" style="max-width: 18rem;" id="alerta_' + item.id_alerta + '"> <div class="card-body">\n\
            <center>\n\
            <p class="card-text">'+ item.nom_alerta + '</p>\n\
            </center>\n\
            </div>\n\
            </a>');
          }
        });
      } else {
        $('#divCards').html(response.Mensaje)
      }
    },
    beforeSend: function () {
      $('#divCards').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $('#modal_msg').modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function show_Alerta(id) {

  update_Alertas(id);

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Alertas.php/id/'+id,
    data: alertas,
    dataType: 'json',
    success: function (response) {
      if (response.Respuesta != 0) {
        $("#alertas_modTittle").html(response.Respuesta[0].nom_alerta);
        $("#alertas_modDesc").html(response.Respuesta[0].desc_alerta);
        $("#alertas_modFecha").html(response.Respuesta[0].fecha_alerta);
        $('#alertas_mod_mostrar').modal({ backdrop: 'static', keyboard: true, show: true })
      } else {
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({ backdrop: 'static', keyboard: true, show: true })
      }
    },
    beforeSend: function () {

    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $('#ins_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({ backdrop: 'static', keyboard: true, show: true });
  });
}

function update_Alertas(id) {

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Alertas.php/actualizar/'+id,
    data: alertas,
    dataType: 'json',
    success: function (response) {
      if (response.Respuesta != 0) {
        $('#alerta_' + id).removeClass('text-white bg-primary');
        $('#alerta_' + id).addClass('bg-light');
      }
    },
    beforeSend: function () {

    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({ backdrop: 'static', keyboard: true, show: true });
  });

}

function ValidacionesAlertas(respuesta) {
  
  if (respuesta != 0) {
    var cantidad = respuesta.alertas_cantidad
    var toast = parseInt(localStorage.getItem("toast"))
    if (cantidad > 0) {
      $("#badgeAlert").html(cantidad);
      $("#badgeAlert").show();
      if (cantidad != toast) {
        NotificacionToast(cantidad);
      }
    } else {
      $("#badgeAlert").hide();
      localStorage.setItem("toast", 0)
    }
  } else {
    $("#badgeAlert").hide();
    localStorage.setItem("toast", 0)
  }
}

function NotificacionToast(cant) {

  if (!("Notification" in window)) {
    alert("This browser does not support desktop notification");
  }

  var title = "Shake It Admin";
  var extra = {
    icon: "media/favicon.png",
    body: "Tiene " + cant + " notificaciones sin revisar"
  }
  // Lanzamos la notificación
  new Notification(title, extra)
  localStorage.setItem("toast", cant);
}

function get_Cantidad2() {

  var xmlhttp = new XMLHttpRequest();
  var url = 'Api/v1/Alertas.php/cantidad/'+GlobalUserid;
  //debugger
  xmlhttp.open("GET", url, true);
  xmlhttp.onreadystatechange = function () {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
    //  debugger
      var datos = JSON.parse(xmlhttp.responseText);
      var respuesta = datos.Respuesta[0]
      ValidacionesAlertas(respuesta)
    }
  };
  xmlhttp.send();
}

function get_Cantidad(){
     var param = window.btoa(GlobalUserid + '|' + "Dato");
  var url ='wss://softansol.com:8000/ShakeIt_Admin/Api/v1/Alertas.php' + "?cantidad=" + param;
    const socket = new WebSocket(url);
    
    socket.addEventListener('message', function (event) {
    console.log('Message from server', event.data);
});
    
}