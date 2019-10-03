/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function Load_Insumos() {

 $('#modal_msg').modal('hide');

   var insumos = {
     "insumos": "insumos"
   };
   $.ajax({
     type: 'GET',
     url: 'Api/v1/Insumos.php',
     data: insumos,
     dataType: 'json',
     success: function(response) {
       if (response.Respuesta != 0) {
         $('#tab_InsBody').html('')
         $.each(response.Respuesta, function(i, item) {
           $('#tab_InsBody').append('<tr>\n\
                  <th scope="row">' + item.id_insumo + '</th>\n\
                  <td>' + item.nom_insumo + '</td>\n\
                  <td>' + item.nomSI_unidad + '</td>\n\
                  <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Insumo(' + item.id_insumo + ')" role="button">Editar</a>\n\
                  </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_insumo + ')" role="button">Eliminar</a></td>\n\
                  </tr>');
       });
       } else {
         $('#tab_InsBody').html(response.Mensaje)
       }
     },
     beforeSend: function() {
       $('#tab_InsBody').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function show_Insumo(id) {

  var dataserver = id + '|' + "Dato"
  var dataserverb = window.btoa(dataserver);
  var insumo = {
      "insumo": dataserverb
  };

  $.ajax({
      type: 'POST',
      url: 'Api/v1/Insumos.php',
      data: insumo,
      dataType: 'json',
      success: function (response) {
          if (response.Respuesta != 0) {
            $("#ins_ide").val(response.Respuesta[0].id_insumo);
            $("#ins_nome").val(response.Respuesta[0].nom_insumo);
            $("#ins_cante").val(response.Respuesta[0].cantmin_insumo);
            $("#ins_unie").val(response.Respuesta[0].id_unidad);
            $('#ins_mod_editar').modal({backdrop: 'static', keyboard: true, show: true})
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
      $("#modal_msg").modal({backdrop: 'static', keyboard: true, show: true});
  });
}

function update_insumos() {

  var id = $('#ins_ide').val();
  var nom = $('#ins_nome').val();
  var cant = $('#ins_cante').val();
  var uni = $('#ins_unie').val();

    var dataserver = id + '|' + nom + '|' + uni + '|' + cant
    var dataserverb = window.btoa(dataserver);
    var insumo = {
        "actualizar": dataserverb
    };

    console.log(dataserverb);

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Insumos.php',
        data: insumo,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
                $('#ins_mod_editar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Insumos()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $("#insActualizar").show()
                $("#insActualizando").hide()
                $('#ins_mod_editar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            }
        },
        beforeSend: function () {
          $("#insActualizar").hide()
          $("#insActualizando").show()
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#ins_mod_editar').modal('hide')
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal({backdrop: 'static', keyboard: true, show: true});
        $("#insActualizar").show()
        $("#insActualizando").hide()
    });

}

function delete_insumos(id) {

    var dataserver = id + '|' + "Dato"
    var dataserverb = window.btoa(dataserver);
    var insumo = {
        "eliminar": dataserverb
    };

    console.log(dataserverb);

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Insumos.php',
        data: insumo,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
                $('#ins_mod_editar').modal('hide')
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Insumos()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
                $('#ins_mod_editar').modal('hide')
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
        $("#modal_msg").modal({backdrop: 'static', keyboard: true, show: true});
        $("#ingresar").show();
        $("#ingresando").hide();
    });

}

function insert_insumos() {

  var nom = $('#ins_nomg').val();
  var cant = $('#ins_cantg').val();
  var uni = $('#ins_unig').val();


    var dataserver = nom + '|' + uni + '|' + cant
    var dataserverb = window.btoa(dataserver);
    var insumos = {
        "insertar": dataserverb
    };

    console.log(dataserverb);

    $.ajax({
        type: 'POST',
        url: 'Api/v1/Insumos.php',
        data: insumos,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
              $("#ins_mod_guardar").modal("hide");
                $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Insumos()' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            } else {
              $("#ins_mod_guardar").modal("hide");
                $("#insGuardar").show()
                $("#insGuardando").hide()
                $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
                $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
                $('#modal_msg').modal({backdrop: 'static', keyboard: true, show: true})
            }
        },
        beforeSend: function () {
          $("#insGuardar").hide()
          $("#insGuardando").show()
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
      $("#ins_mod_guardar").modal("hide");
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal({backdrop: 'static', keyboard: true, show: true});
        $("#insGuardar").show()
        $("#insGuardando").hide()
    });

}
