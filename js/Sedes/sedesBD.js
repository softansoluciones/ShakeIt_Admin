function Load_Sedes() {

  $('#modal_msg').modal('hide');

  var sedes = {
    "sedes": "sedes"
  };
  $.ajax({
    type: 'GET',
    url: 'Api/v1/Sedes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#tab_sedeBody').html('')
        $.each(response.Respuesta, function(i, item) {
          $('#tab_sedeBody').append('<tr>\n\
                  <th scope="row">' + item.id_sede + '</th>\n\
                  <td>' + item.nom_sede + '</td>\n\
                  <td>' + item.dir_sede + '</td>\n\
                  <td>' + item.tel1_sede + '</td>\n\
                  <td>' + item.tel2_sede + '</td>\n\
                  <td>' + item.nom_municipio + '</td>\n\
                  <td>' + item.nom_departamento + '</td>\n\
                  <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Sede(' + item.id_sede + ')" role="button">Editar</a>\n\
                  </tr>');
        });
      } else {
        $('#tab_sedeBody').html(response.Mensaje)
      }
    },
    beforeSend: function() {
      $('#tab_sedeBody').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function get_sedexnom() {

  var nom = $('#sede_nomg').val();

  var dataserver = nom + '|data'
  var dataserverb = window.btoa(dataserver);
  var sedes = {
    "sedexnom": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Sedes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#msg_alert_modG").html('<p>Ya existe sede con el nombre </p>' + nom);
        $('#sede_nomg').focus()
        $('#sede_nomg').val("")
        $('#sede_nomg').addClass('is-invalid')
        $("#msg_alert_modG").show();
      }
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#sede_mod_guardar").modal("hide");
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $("#sedeGuardar").show()
    $("#sedeGuardando").hide()
  });
}

function insert_sedes() {

  var nit = $('#sede_nitg').val();
  var nom = $('#sede_nomg').val();
  var dir = $('#sede_dirg').val();
  var mun = $('#sede_mung').val();
  var tel1 = $('#sede_tel1g').val();
  var tel2 = $('#sede_tel2g').val();
  var tel3 = $('#sede_tel3g').val();
  var long = $('#sede_longg').val();
  var lat = $('#sede_latg').val();

  var dataserver = nit + '|' + nom + '|' + dir + '|' + mun + '|' + tel1 + '|' + tel2 + '|' + tel3 + '|' + long + '|' + lat
  var dataserverb = window.btoa(dataserver);
  var sedes = {
    "insertar": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Sedes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#sede_mod_guardar").modal("hide");
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Sedes()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#sede_mod_guardar").modal("hide");
        $("#sedeGuardar").show()
        $("#sedeGuardando").hide()
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
      $("#sedeGuardar").hide()
      $("#sedeGuardando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#sede_mod_guardar").modal("hide");
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $("#sedeGuardar").show()
    $("#sedeGuardando").hide()
  });
}

function show_Sede(id) {

  var dataserver = id + '|' + "Dato"
  var dataserverb = window.btoa(dataserver);
  var sede = {
    "sede": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Sedes.php',
    data: sede,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#sede_ide').val(response.Respuesta[0].id_sede);
        $('#sede_nite').val(response.Respuesta[0].nit_sede);
        $('#sede_nome').val(response.Respuesta[0].nom_sede);
        $('#sede_dire').val(response.Respuesta[0].dir_sede);
        $('#sede_depe').val(response.Respuesta[0].fk_departamento);
        $('#sede_mune').val(response.Respuesta[0].id_municipio);
        $('#sede_tel1e').val(response.Respuesta[0].tel1_sede);
        $('#sede_tel2e').val(response.Respuesta[0].tel2_sede);
        $('#sede_tel3e').val(response.Respuesta[0].tel3_sede);
        $('#sede_longe').val(response.Respuesta[0].long_sede);
        $('#sede_late').val(response.Respuesta[0].lat_sede);
        $('#sede_mod_editar').modal({
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
    $('#sede_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function update_sedes() {

  var id = $('#sede_ide').val();
  var nit = $('#sede_nite').val();
  var nom = $('#sede_nome').val();
  var dir = $('#sede_dire').val();
  var mun = $('#sede_mune').val();
  var tel1 = $('#sede_tel1e').val();
  var tel2 = $('#sede_tel2e').val();
  var tel3 = $('#sede_tel3e').val();
  var long = $('#sede_longe').val();
  var lat = $('#sede_late').val();

  var dataserver = id + '|' + nit + '|' + nom + '|' + dir + '|' + mun + '|' + tel1 + '|' + tel2 + '|' + tel3 + '|' + long + '|' + lat
  var dataserverb = window.btoa(dataserver);
  var sedes = {
    "actualizar": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Sedes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#sede_mod_editar").modal("hide");
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Sedes()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $("#sede_mod_editar").modal("hide");
        $("#sedeActualizar").show()
        $("#sedeActualizando").hide()
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
      $("#sedeActualizar").hide()
      $("#sedeActualizando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $("#sede_mod_editar").modal("hide");
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $("#sedeActualizar").show()
    $("#sedeActualizando").hide()
  });
}
