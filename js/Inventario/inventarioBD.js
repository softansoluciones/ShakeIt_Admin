function Load_Inventario() {

$('#modal_msg').modal('hide');

  var inventario = {
    "inventario": "inventario"
  };
  $.ajax({
    type: 'GET',
    url: 'Api/v1/Inventario.php',
    data: inventario,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#tab_InvBody').html('')
        $.each(response.Respuesta, function(i, item) {
          $('#tab_InvBody').append('<tr>\n\
                 <th scope="row">' + item.id_inventario + '</th>\n\
                 <td>' + item.nom_insumo + '</td>\n\
                 <td>' + item.cantidad_inventario + '</td>\n\
                 <td>' + item.unidad + '</td>\n\
                 <td>' + item.nom_sede + '</td>\n\
                 <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Iventario(' + item.id_inventario + ')" role="button">Editar</a>\n\
                 </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_inventario + ')" role="button">Eliminar</a></td>\n\
                 </tr>');
        });
      } else {
        $('#tab_InvBody').html(response.Mensaje)
      }
    },
    beforeSend: function() {
      $('#tab_InvBody').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $('#modal_msg').modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function show_Iventario(id) {

    var dataserver = id + '|' + "Dato"
    var dataserverb = window.btoa(dataserver);
    var inventario = {
        "inventarioxid": dataserverb
    };

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Inventario.php',
        data: inventario,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
              $("#inv_ide").val(response.Respuesta[0].id_inventario);
              $("#inv_inse").val(response.Respuesta[0].fk_insumo);
              $("#inv_cante").val(response.Respuesta[0].cantidad_inventario);
              $("#inv_unidade").val(response.Respuesta[0].unidad);
              $("#inv_sedee").val(response.Respuesta[0].sede_inventario);
              $('#inv_mod_editar').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            }
        },
        beforeSend: function () {

        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#ins_mod_editar').modal('hide')
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal('show');
        $("#ingresar").show();
        $("#ingresando").hide();
    });

}

function Load_Sedes() {

    var sedes = {
        "sedes": "sedes"
    };

    $.ajax({
        type: 'GET',
        url: 'Api/v1/Comunes.php',
        data: sedes,
        dataType: 'json',
        success: function (response) {
            $('#tab_SedInvBody').html("")
            if (response.Respuesta != 0) {
                $.each(response.Respuesta, function (i, item) {
                    $('#tab_SedInvBody').append('\
                    <tr>\n\
                      <td>'+item.id+'</td>\n\
                      <td>'+item.nom+'</td>\n\
                      <td><center><input type="checkbox" name="sedCheck" data-id="'+item.id+'" class="form-check-input"></center></td>\n\
                    </tr>');
                });
            } else {
                $('#tab_SedInvBody').html('No existe información');
            }
        }
    });
}

function update_inventario() {

  var id = $("#inv_ide").val();
  var ins = $("#inv_inse").val();
  var cant = $("#inv_cante").val();
  var sed = $("#inv_sedee").val();

    var dataserver = id + '|' + ins + '|' + cant + '|' + sed
    var dataserverb = window.btoa(dataserver);
    var insumo = {
        "actualizar": dataserverb
    };

    console.log(dataserverb);

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Inventario.php',
        data: insumo,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
                $('#inv_mod_editar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Load_Inventario()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $("#invActualizar").show()
                $("#invActualizando").hide()
                $('#ins_mod_editar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            }
        },
        beforeSend: function () {
          $("#invActualizar").hide()
          $("#invActualizando").show()
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#ins_mod_editar').modal('hide')
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal('show');
        $("#invActualizar").show()
        $("#invActualizando").hide()
    });

}

function delete_inventario(id) {

    var dataserver = id + '|' + "Dato"
    var dataserverb = window.btoa(dataserver);
    var inventario = {
        "eliminar": dataserverb
    };

    console.log(dataserverb);

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Inventario.php',
        data: inventario,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Load_Inventario()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            }
        },
        beforeSend: function () {

        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#ins_mod_editar').modal('hide')
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal('show');
        $("#ingresar").show();
        $("#ingresando").hide();
    });

}

function insert_inventario() {

var datos = RecorrerSedes();

  INFO = new FormData();
  var ainfo = JSON.stringify(datos);
  INFO.append('insertarmas', ainfo);
  $.ajax({
      type: "POST",
      processData: false,
      contentType: false,
      cache: false,
      data: INFO,
        url: 'Api/v1/Inventario.php',
        success: function (response) {

            if (response.Respuesta != 0) {
                $('#inv_mod_guardar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Load_Inventario()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $("#invGuardar").show()
                $("#invGuardando").hide()
                $('#msg_alert_mod').html("<center><p>" + response.Mensaje + "</p></center>");
                $('#msg_alert_mod').show('fast')
            }
        },
        beforeSend: function () {
          $("#invGuardar").hide()
          $("#invGuardando").show()
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#msg_alert_mod').html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $('#msg_alert_mod').show('fast');
        $("#invGuardar").show()
        $("#invGuardando").hide()
    });

}
