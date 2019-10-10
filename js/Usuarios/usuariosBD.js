var nGlobalmodulo = sessionStorage.getItem("modulo");
function Load_Usuarios() {

  $('#modal_msg').modal('hide');

  var userltip = parseInt(sessionStorage.getItem("tipo_user"))
  var userlid = parseInt(sessionStorage.getItem("id_user"))
  
  $.ajax({
    type: 'GET',
    url: 'Api/v1/Usuarios.php/lista',
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#tab_userBody').html('')
        $.each(response.Respuesta, function(i, item) {
          //debugger
          if (userltip == 3) {
            $('#tab_userBody').append('<tr>\n\
                    <th scope="row">' + item.id_usuario + '</th>\n\
                    <td>' + item.doc_usuario + '</td>\n\
                    <td>' + item.nom_usuario + '</td>\n\
                    <td>' + item.ape_usuario + '</td>\n\
                    <td>' + item.tel_usuario + '</td>\n\
                    <td>' + item.nom_tipo + '</td>\n\
                    <td>' + item.nomcomun_estado + '</td>\n\
                    <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Usuario(' + item.id_usuario + ')" role="button">Editar</a>\n\
                    </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_usuario + ')" role="button">Eliminar</a></td>\n\
                    </tr>');
          }
          if (userltip == 2 && item.tipo_usuario != 3 && item.id_usuario != userlid) {
            $('#tab_userBody').append('<tr>\n\
                    <th scope="row">' + item.id_usuario + '</th>\n\
                    <td>' + item.doc_usuario + '</td>\n\
                    <td>' + item.nom_usuario + '</td>\n\
                    <td>' + item.ape_usuario + '</td>\n\
                    <td>' + item.tel_usuario + '</td>\n\
                    <td>' + item.nom_tipo + '</td>\n\
                    <td>' + item.nomcomun_estado + '</td>\n\
                    <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Usuario(' + item.id_usuario + ')" role="button">Editar</a>\n\
                    </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_usuario + ')" role="button">Eliminar</a></td>\n\
                    </tr>');
          }

          if (userltip == 4 && item.id_usuario != userlid) {
            if (item.tipo_usuario != 3) {
              if (item.tipo_usuario != 2) {
                $('#tab_userBody').append('<tr>\n\
                        <th scope="row">' + item.id_usuario + '</th>\n\
                        <td>' + item.doc_usuario + '</td>\n\
                        <td>' + item.nom_usuario + '</td>\n\
                        <td>' + item.ape_usuario + '</td>\n\
                        <td>' + item.tel_usuario + '</td>\n\
                        <td>' + item.nom_tipo + '</td>\n\
                        <td>' + item.nomcomun_estado + '</td>\n\
                        <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Usuario(' + item.id_usuario + ')" role="button">Editar</a>\n\
                        </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_usuario + ')" role="button">Eliminar</a></td>\n\
                        </tr>');
              }
            }
          }
        });
      } else {
        $('#tab_userBody').html(response.Mensaje)
      }
    },
    beforeSend: function() {
      $('#tab_userBody').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function verificarUs() {

  doc = $('#us_docg').val()

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Usuarios.php/documento/'+doc,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#us_docg').addClass("is-invalid");
        $('#us_docg').focus();
        $("#msg_alert_modG").html("<center><p>El usuario <strong>" + response.Respuesta[0].nom_usuario + " " + response.Respuesta[0].ape_usuario + "</strong> ya se encuentra registrado</p></center>")
        $("#msg_alert_modG").show("fast")
        $('#us_docg').val("")
      }
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#user_mod_guardar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function insert_Usuarios() {

  var doc = $('#us_docg').val();
  var nom = $('#us_nomg').val();
  var ape = $('#us_apeg').val();
  var tel = $('#us_telg').val();
  var email = $('#us_emailg').val();
  var pass = $('#us_docg').val();
  var tipo = $('#us_tipog').val();
  var estado = 2;
  
  var usuario = {
    
    "documento_usuario": doc,
    "nombres_usuario": nom,
    "apellidos_usuario": ape,
    "telefono_usuario": tel,
    "email_usuario": email,
    "password_usuario": pass,
    "tipo_usuario": tipo,
    "estado_usuario": estado

  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Usuarios.php/guardar',
    data: usuario,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#user_mod_guardar").modal("hide");
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Usuarios()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#user_mod_guardar").modal("hide");
        $("#usGuardar").show()
        $("#usGuardando").hide()
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      }
    },
    beforeSend: function() {
      $("#usGuardar").hide()
      $("#usGuardando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#user_mod_guardar").modal("hide");
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $("#insGuardar").show()
    $("#insGuardando").hide()
  });

}

function show_Usuario(id) {

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Usuarios.php/id/'+id,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#msg_alert_modE").hide();
        $("#usResetPass").removeClass("disabled");
        $(".is-invalid").removeClass("is-invalid")
        $("#us_ide").val(response.Respuesta[0].id_usuario);
        $("#us_doce").val(response.Respuesta[0].doc_usuario);
        $("#us_nome").val(response.Respuesta[0].nom_usuario);
        $("#us_apee").val(response.Respuesta[0].ape_usuario);
        $("#us_tele").val(response.Respuesta[0].tel_usuario);
        $("#us_emaile").val(response.Respuesta[0].email_usuario);
        $("#us_passe").val(response.Respuesta[0].pass_usuario);
        if (nGlobalmodulo != "6") {
          $("#us_oldpasse").val(response.Respuesta[0].pass_usuario);
          $("#us_oldpasse").hide()
        } else {
          $("#us_oldpasse").val("");
          $("#us_oldpasse").show()
        }
        $("#us_pass1e").val("");
        $("#us_pass2e").val("");
        $("#us_tipoe").val(response.Respuesta[0].tipo_usuario);
        $("#us_estadoe").val(response.Respuesta[0].estado_usuario);
        $('#user_mod_editar').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      }
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#user_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });

}

function update_Usuarios() {

  var id = $('#us_ide').val();
  var doc = $('#us_doce').val();
  var nom = $('#us_nome').val();
  var ape = $('#us_apee').val();
  var tel = $('#us_tele').val();
  var email = $('#us_emaile').val();
  if ($("#usPass_btn").hasClass("btn_sh_normal") && nGlobalmodulo == "6") {
    var pass = $('#us_passe').val();
  }else {
    if (nGlobalmodulo == "5") {
      var pass = $('#us_passe').val();
    }else {
    var pass = hex_md5($('#us_pass2e').val());
    }
  }
  var tipo = $('#us_tipoe').val();
  var estado = $('#us_estadoe').val();;

  
  var usuario = {
    
    "documento_usuario": doc,
    "nombres_usuario": nom,
    "apellidos_usuario": ape,
    "telefono_usuario": tel,
    "email_usuario": email,
    "password_usuario": pass,
    "tipo_usuario": tipo,
    "estado_usuario": estado

  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Usuarios.php/actualizar/'+id,
    data: usuario,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#user_mod_editar").modal("hide");
        $("#user_modal_log").modal("hide");
        if (nGlobalmodulo == "5") {
          $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Usuarios()' role='button'>Aceptar</a>");
        }else {
          $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: ActualizarPagina()' role='button'>Aceptar</a>");
        }
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#user_mod_editar").modal("hide");
        $("#user_modal_log").modal("hide");
        $("#usactualizar").show()
        $("#usActualizando").hide()
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      }
    },
    beforeSend: function() {
      $("#usActualizar").hide()
      $("#usActualizando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#user_mod_editar").modal("hide");
    $("#user_modal_log").modal("hide");
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $("#usactualizar").show()
    $("#usActualizando").hide()
  });

}

function delete_Usuarios(id) {

  $.ajax({
    type: 'DELETE',
    url: 'Api/v1/Usuarios.php/eliminar/'+id,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#user_mod_editar").modal("hide");
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Usuarios()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      }
    },
    beforeSend: function() {}
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });

}
