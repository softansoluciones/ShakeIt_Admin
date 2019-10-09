function Load_Ventas(fecha, dia, mes, anio, sede) {

  var ventas = {
    "fecha": fecha,
    "dia": dia,
    "mes": mes,
    "anio": anio,
    "sede": sede,

  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Ventas.php/filtros',
    data: ventas,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function (response) {
      if (response.Respuesta != 0) {

        $('#tab_Ventas').html('')
        $.each(response.Respuesta.Data, function (i, item) {
          $('#tab_Ventas').append('<tr><th scope="row">' + item.id_venta + '</th><td>' + item.num_factura + '</td><td>' + item.cant_productos + '</td><td>' + item.nom_consumo + '</td><td>' + item.nommedio_pago + '</td><td>' + item.nom_entidad + '</td><td>' + item.val_venta + '</td><td>' + item.fecha + '</td><td>' + item.hora + '</td><td>' + item.nom_sede + '</td><td><a class="btn btn_sh_normal btn-sm" href="javascript: showVenta(' + item.id_venta + ')" role="button">Detalle</a></td></tr>')
        });
        $('#vtotal').html(response.Respuesta.Total[0].total);
        $('#bfilt').show();
        $('#bfilting').hide();
        $("#filtrosd").slideUp("slow");
      } else {
        $('#tab_Ventas').html(response.Mensaje)
        $('#vtotal').html('0');
        $('#bfilt').show();
        $('#bfilting').hide();
        $("#filtrosd").slideUp("slow");
      }
    },
    beforeSend: function () {
      $('#tab_Ventas').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')

    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $('#modal_msg').modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $('#bfilt').show();
    $('#bfilting').hide();
  });

}

function Load_VentasAnio(mes, anio, sede) {

  var ventas = {
    "mes": mes,
    "anio": anio,
    "sede": sede,
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Ventas.php/filtroanio',
    data: ventas,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function (response) {
      if (response.Respuesta != 0) {
        $('#tab_Ventas').html('')
        $.each(response.Respuesta.Data, function (i, item) {
          $('#tab_Ventas').append('<tr><th scope="row">' + item.id_venta + '</th><td>' + item.num_factura + '</td><td>' + item.cant_productos + '</td><td>' + item.nom_consumo + '</td><td>' + item.nommedio_pago + '</td><td>' + item.nom_entidad + '</td><td>' + item.val_venta + '</td><td>' + item.fecha + '</td><td>' + item.hora + '</td><td>' + item.nom_sede + '</td><td><a class="btn btn_sh_normal btn-sm" href="javascript: showVenta(' + item.id_venta + ')" role="button">Detalle</a></td></tr>')
        });
        $('#vtotal').html(response.Respuesta.Total[0].total);
        $('#bfilta').show();
        $('#bfiltinga').hide();
        $("#filtrosa").slideUp("slow");
      } else {
        $('#tab_Ventas').html(response.Mensaje)
        $('#vtotal').html('0');
        $('#bfilta').show();
        $('#bfiltinga').hide();
        $("#filtrosa").slideUp("slow");
      }
    },
    beforeSend: function () {
      $('#tab_Ventas').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')

    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $('#modal_msg').modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
    $('#bfilta').show();
    $('#bfiltinga').hide();
  });

}

function showVenta(id) {

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Ventas.php/id/' + id,
    data: venta,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function (response) {
      if (response.Respuesta != 0) {
        $('#det_sede').html('<strong>Sede:</strong> ' + response.Respuesta[0].nom_sede)
        $('#det_fac').html('<strong>Factura:</strong> ' + response.Respuesta[0].num_factura)
        $('#det_cant').html('<strong>Cantidad:</strong> ' + response.Respuesta[0].cant_productos)
        $('#det_consumo').html('<strong>Consumo:</strong> ' + response.Respuesta[0].nom_consumo)
        $('#det_medio').html('<strong>Medio De Pago:</strong> ' + response.Respuesta[0].nommedio_pago)
        $('#det_entidad').html('<strong>Entidad:</strong> ' + response.Respuesta[0].nom_entidad)
        $('#det_total').html('<strong>Total:</strong> ' + response.Respuesta[0].val_venta)
        verDetalle(id);
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
    beforeSend: function () {
      $('#tab_DetVentas').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function verDetalle(id) {

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Ventas.php/detalle/' + id,
    data: detalle,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function (response) {
      if (response.Respuesta != 0) {
        $('#tab_DetVentas').html('')
        $.each(response.Respuesta, function (i, item) {
          $('#tab_DetVentas').append('<tr><th scope="row">' + item.fk_producto + '</th><td>' + item.nom_producto + '</td><td>' + item.cant_vendido + '</td><td>' + item.precio_producto + '</td><td>' + item.descuento + '</td><td>' + item.Total + '</td></tr>')
        });
        $('#det_mod_venta').modal({
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
    beforeSend: function () {
      $('#tab_DetVentas').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
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

function show_filtros(filt) {

  if (filt == "d") {
    $("#filtrosd").slideToggle("slow");
    $("#filtrosa").slideUp("slow");
  }

  if (filt == "a") {
    $("#filtrosa").slideToggle("slow");
    $("#filtrosd").slideUp("slow");
  }

}

function filtros(tfilt) {

  var fecha = $('#fpvdate').val();
  var sede = $('#fpvSedes').val();
  var criterio = verFMarca();
  var sedea = $('#fpvSedesa').val();
  var mes = $('#fpvmes').val();
  var anio = $('#fpvanio').val();

  if (tfilt == 'd') {

    $('#bfilt').hide();
    $('#bfilting').show();

    if (sede.length == 0 && fecha.length == 0) {

      switch (criterio) {
        case "d":
          Load_Ventas('0-0-0', 1, 0, 0, 0);
          break;
        case "m":
          Load_Ventas('0-0-0', 0, 1, 0, 0);
          break;
        case "a":
          Load_Ventas('0-0-0', 0, 0, 1, 0);
          break;
        default:
          Load_Ventas('0-0-0', 1, 0, 0, 0);
      }
    } else if (sede.length != 0 && fecha.length == 0) {
      switch (criterio) {
        case "d":
          Load_Ventas('0-0-0', 1, 0, 0, sede);
          break;
        case "m":
          Load_Ventas('0-0-0', 0, 1, 0, sede);
          break;
        case "a":
          Load_Ventas('0-0-0', 0, 0, 1, sede);
          break;
        default:
          Load_Ventas('0-0-0', 1, 0, 0, sede);
      }
    } else if (sede.length == 0 && fecha.length != 0) {
      Load_Ventas(fecha, 0, 0, 0, 0);
    } else if (sede.length != 0 && fecha.length != 0) {
      Load_Ventas(fecha, 0, 0, 0, sede);
    }

  }

  if (tfilt == 'a') {

    $('#bfilta').hide();
    $('#bfiltinga').show();

    if (sedea.length == 0 && mes.length == 0 && anio.length == 0) {
      Load_VentasAnio(0, 0, 0);
    } else if (sedea.length == 0 && mes.length == 0 && anio.length != 0) {
      Load_VentasAnio(0, anio, 0);
    } else if (sedea.length == 0 && mes.length != 0 && anio.length != 0) {
      Load_VentasAnio(mes, anio, 0);
    } else if (sedea.length != 0 && mes.length != 0 && anio.length != 0) {
      Load_VentasAnio(mes, anio, sedea);
    } else if (sedea.length != 0 && mes.length == 0 && anio.length != 0) {
      Load_VentasAnio(0, anio, sedea);
    } else if (mes.length != 0 && anio.length == 0 && sedea.length == 0 || mes.length != 0 && anio.length == 0 && sedea.length != 0) {
      $.notify("No puede filtrar solo por mes, es necesario que escoja un año", {
        animate: {
          enter: 'animated fadeInRight',
          exit: 'animated fadeOutRight',
          position: 'absolute'
        }
      });
      anio.focus();
      anio.addClass('is-invalid')
    } else
      Load_VentasAnio(0, 0, 0);
  }

}

function verFMarca() {
  var criterio;
  $("a[name ='filter_pv']").each(function () {
    if ($(this).hasClass('active_nav')) {
      criterio = $(this).data("criterio");
    }
  });
  return criterio;
}

function filterPV(link) {
  removeActiveFilter()
  $(link).addClass("active_nav");
}

function removeActiveFilter() {
  $("a[name ='filter_pv']").each(function () {
    $(this).removeClass("active_nav");
  });
}

$(document).ready(function () {
  Load_Ventas('0-0-0', 1, 0, 0, 0);
  Get_SedesSel("#fpvSedes");
  Get_SedesSel("#fpvSedesa");
  Get_AniosSel("#fpvanio");
  Get_MesesSel("#fpvmes");
})