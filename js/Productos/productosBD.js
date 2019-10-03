/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function Load_Productos() {

  $('#modal_msg').modal('hide');

  var productos = {
    "productos": "productos"
  };
  $.ajax({
    type: 'GET',
    url: 'Api/v1/Productos.php',
    data: productos,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#tab_ProBody').html('')
        $.each(response.Respuesta, function(i, item) {
          $('#tab_ProBody').append('<tr>\n\
                   <th scope="row">' + item.id_producto + '</th>\n\
                   <td>' + item.nom_producto + '</td>\n\
                   <td>' + item.nomG_producto + '</td>\n\
                   <td>' + item.precio_producto + '</td>\n\
                   <td>' + item.nomcategoria + '</td>\n\
                   <td><a class="btn btn_sh_normal btn-sm" href="javascript: show_Producto(' + item.id_producto + ')" role="button">Editar</a>\n\
                   </td><td><a class="btn btn-danger btn-sm" href="javascript: confirmarEliminar(' + item.id_producto + ')" role="button">Eliminar</a></td>\n\
                   </tr>')
        });
      } else {
        $('#tab_ProBody').html(response.Mensaje)
      }
    },
    beforeSend: function() {
      $('#tab_ProBody').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function show_Producto(id) {

  var dataserver = id + '|' + "Dato"
  var dataserverb = window.btoa(dataserver);
  var producto = {
    "producto": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Productos.php',
    data: producto,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#pro_mod_nuevo_insumos").html("")
        $("#num_ins").val(0);
        $('#pro_ide').val(response.Respuesta[0].id_producto)
        $('#pro_nome').val(response.Respuesta[0].nom_producto)
        $('#pro_nomce').val(response.Respuesta[0].nomG_producto)
        $('#pro_prece').val(response.Respuesta[0].precio_producto)
        $('#pro_cate').val(response.Respuesta[0].fk_categoria)
        $('#pro_desce').val(response.Respuesta[0].descripcion_producto)
        Get_InsumosProd(id)
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
    $('#ins_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function Get_InsumosProd(id) {

  var dataserver = id + '|' + "Dato"
  var dataserverb = window.btoa(dataserver);
  var producto = {
    "relacionxprod": dataserverb
  };

  $.ajax({
    type: 'POST',
    url: 'Api/v1/RelacionInsumos.php',
    data: producto,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $("#pro_mod_editar_insumos").html("")
        $.each(response.Respuesta, function(i, item) {
          $('#pro_mod_editar_insumos').append('\
                    <div class="alert alert-primary row" role="alert" id="regIns-' + item.fk_insumo + '">\n\
                    <div class="col-5" style="display: none;"><input id="ins_i" name="ins_gd" value="' + item.fk_insumo + '" /></div>\n\
                    <div class="col-5">' + item.nom_insumo + '</div>\n\
                    <div class="col-3">Cantidad: ' + item.insumoUnidad_rel + '</div>\n\
                    <div class="col-3">' + item.nomSI_unidad + '(' + item.simbolo_unidad + ')</div>\n\
                    <div class="col-1"><a href="javascript: delete_Relacion(' + item.fk_producto + ',' + item.fk_insumo + ')"><i class="far fa-trash-alt"></i></div></a>\n\
                    </div>')
        });
      }
      $('#pro_mod_editar').modal({
        backdrop: 'static',
        keyboard: true,
        show: true
      })
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#ins_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}

function delete_Relacion(pro, ins) {

  var dataserver = pro + '|' + ins
  var dataserverb = window.btoa(dataserver);
  var persona = {
    "eliminar": dataserverb
  };

  console.log(dataserverb);

  $.ajax({
    type: 'POST',
    url: 'Api/v1/RelacionInsumos.php',
    data: persona,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#regIns-' + ins).remove();
      } else {
        ('#msg_alert_mod').html('<p>Error al eliminar producto.</p>');
        $('#msg_alert_mod').show('fast');
      }
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#pro_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#ingresar").show();
    $("#ingresando").hide();
  });

}

function update_producto() {

  var id = $('#pro_ide').val();
  var nom = $('#pro_nome').val();
  var nomG = $('#pro_nomce').val();
  var prec = $('#pro_prece').val();
  var cat = $('#pro_cate').val();
  var desc = $('#pro_desce').val();

  var dataserver = id + '|' + nom + '|' + nomG + '|' + prec + '|' + cat + '|' + desc
  var dataserverb = window.btoa(dataserver);
  var persona = {
    "actualizar": dataserverb
  };

  console.log(dataserverb);

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Productos.php',
    data: persona,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#pro_mod_editar').modal('hide')
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Productos()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $('#pro_mod_editar').modal('hide')
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
        $("#proActualizar").show()
        $("#proActualizando").hide()
      }
    },
    beforeSend: function() {
      $("#proActualizar").hide()
      $("#proActualizando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#pro_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#proActualizar").show()
    $("#proActualizando").hide()
  });

}

function insert_RelacionMas(datos, val) {

  INFO = new FormData();
  var ainfo = JSON.stringify(datos);
  INFO.append('insertarmas', ainfo);

  $.ajax({

    type: "POST",
    processData: false,
    contentType: false,
    cache: false,
    data: INFO,
    url: 'Api/v1/RelacionInsumos.php',
    success: function(response) {

      if (response.Respuesta != 0) {

        if (val == 1) {
          insert_producto();
        } else {
          update_producto();
        }

      }
    },
    beforeSend: function() {

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#pro_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#proGuardar").show()
    $("#proGuardando").hide()
    $("#proActualizar").show()
    $("#proActuaizando").hide()
  });

}

function delete_productos(id) {

  var dataserver = id + '|' + 'dato'
  var dataserverb = window.btoa(dataserver);
  var producto = {
    "eliminar": dataserverb
  };

  console.log(dataserverb);

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Productos.php',
    data: producto,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#pro_mod_editar').modal('hide')
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_Productos()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $('#pro_mod_editar').modal('hide')
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
    $('#pro_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#ingresar").show();
    $("#ingresando").hide();
  });

}

function id_producto() {

  var request = {
    "getid": "getid"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Productos.php',
    data: request,
    dataType: 'json',
    success: function(response) {

      $("#pro_idg").val(response.Respuesta[0].nid);

    }
  });
}

function insert_producto() {

  var id = $('#pro_idg').val();
  var nom = $('#pro_nomg').val();
  var nomG = $('#pro_nomcg').val();
  var prec = $('#pro_precg').val();
  var cat = $('#pro_catg').val();
  var desc = $('#pro_descg').val();

  var dataserver = id + '|' + nom + '|' + nomG + '|' + prec + '|' + cat + '|' + desc
  var dataserverb = window.btoa(dataserver);
  var producto = {
    "insertar": dataserverb
  };

  console.log(dataserverb);

  $.ajax({
    type: 'POST',
    url: 'Api/v1/Productos.php',
    data: producto,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#pro_mod_editar').modal('hide')
        $("#btns").html("<a class='btn btn-danger btn-sm' href='javascript: Vista_ProductosReg()' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
      } else {
        $('#pro_mod_editar').modal('hide')
        $("#btns").html("<a class='btn btn-danger btn-sm' data-dismiss='modal' aria-label='Close' role='button'>Aceptar</a>");
        $("#msg").html("<center><p>" + response.Mensaje + "</p></center>");
        $('#modal_msg').modal({
          backdrop: 'static',
          keyboard: true,
          show: true
        })
        $("#proGuardar").show()
        $("#proGuardando").hide()
      }
    },
    beforeSend: function() {
      $("#proGuardar").hide()
      $("#proGuardando").show()
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    $('#pro_mod_editar').modal('hide')
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $("#modal_msg").modal('show');
    $("#proGuardar").show()
    $("#proGuardando").hide()
  });

}
