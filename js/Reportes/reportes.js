function Load_ProductosV(fecha, dia, mes, anio, sede) {
  var dataserver = fecha + "|" + dia + "|" + mes + "|" + anio + "|" + sede
  var dataserverb = window.btoa(dataserver);
  var productosv = {
    "productosv": dataserverb
  };
  $.ajax({
    type: 'GET',
    url: 'Api/v1/ProductosVendidos.php',
    data: productosv,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        debugger
        $('#tab_VentasXDia').html('')
        $.each(response.Respuesta.Data, function(i, item) {
          $('#tab_VentasXDia').append('<tr><th scope="row">' + item.fk_producto + '</th><td>' + item.nom_producto + '</td><td>' + item.precio_producto + '</td><td>' + item.cantidad + '</td><td>' + item.valor + '</td><td>' + item.nom_sede + '</td></tr>')
        });
        $('#vtotal').html(response.Respuesta.Total[0].total);
        $('#bfilt').show();
        $('#bfilting').hide();
        $("#filtrosd").slideUp("slow");
      } else {
        $('#tab_VentasXDia').html(response.Mensaje)
        $('#vtotal').html('0');
        $('#bfilt').show();
        $('#bfilting').hide();
        $("#filtrosd").slideUp("slow");
      }
    },
    beforeSend: function() {
      $('#tab_VentasXDia').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')
    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
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

function Load_ProductosVAnio(mes, anio, sede) {
  var dataserver = mes + "|" + anio + "|" + sede
  var dataserverb = window.btoa(dataserver);
  var productosv = {
    "productosvfilt": dataserverb
  };
  $.ajax({
    type: 'GET',
    url: 'Api/v1/ProductosVendidos.php',
    data: productosv,
    dataType: 'json',
    success: function(response) {
      if (response.Respuesta != 0) {
        $('#tab_VentasXDia').html('')
        $.each(response.Respuesta.Data, function(i, item) {
          $('#tab_VentasXDia').append('<tr><th scope="row">' + item.fk_producto + '</th><td>' + item.nom_producto + '</td><td>' + item.precio_producto + '</td><td>' + item.cantidad + '</td><td>' + item.valor + '</td><td>' + item.nom_sede + '</td></tr>')
        });
        $('#vtotal').html(response.Respuesta.Total[0].total);
        $('#bfilta').show();
        $('#bfiltinga').hide();
        $("#filtrosa").slideUp("slow");
      } else {
        $('#tab_VentasXDia').html(response.Mensaje)
        $('#vtotal').html('0');
        $('#bfilta').show();
        $('#bfiltinga').hide();
        $("#filtrosa").slideUp("slow");
      }
    },
    beforeSend: function() {
      $('#tab_VentasXDia').html('<center><div class="text-center"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div></center>')

    }
  }).fail(function(jqXHR, textStatus, errorThrown) {
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

function show_filtros(filt) {

  if (filt == "d") {
    $("#filtrosd").slideToggle("slow");
    $("#filtrosa").slideUp("slow");
  }

  if (filt == "a") {
    $("#filtrosd").slideUp("slow");
    $("#filtrosa").slideToggle("slow");
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
          Load_ProductosV('0-0-0', 1, 0, 0, 0);
          break;
        case "m":
          Load_ProductosV('0-0-0', 0, 1, 0, 0);
          break;
        case "a":
          Load_ProductosV('0-0-0', 0, 0, 1, 0);
          break;
        default:
          Load_ProductosV('0-0-0', 1, 0, 0, 0);
      }
    } else if (sede.length != 0 && fecha.length == 0) {
      switch (criterio) {
        case "d":
          Load_ProductosV('0-0-0', 1, 0, 0, sede);
          break;
        case "m":
          Load_ProductosV('0-0-0', 0, 1, 0, sede);
          break;
        case "a":
          Load_ProductosV('0-0-0', 0, 0, 1, sede);
          break;
        default:
          Load_ProductosV('0-0-0', 1, 0, 0, sede);
      }
    } else if (sede.length == 0 && fecha.length != 0) {
      Load_ProductosV(fecha, 0, 0, 0, 0);
    } else if (sede.length != 0 && fecha.length != 0) {
      Load_ProductosV(fecha, 0, 0, 0, sede);
    }

  }

  if (tfilt == 'a') {

    $('#bfilta').hide();
    $('#bfiltinga').show();

    if (sedea.length == 0 && mes.length == 0 && anio.length == 0) {
      Load_ProductosVAnio(0, 0, 0);
    } else if (sedea.length == 0 && mes.length == 0 && anio.length != 0) {
      Load_ProductosVAnio(0, anio, 0);
    } else if (sedea.length == 0 && mes.length != 0 && anio.length != 0) {
      Load_ProductosVAnio(mes, anio, 0);
    } else if (sedea.length != 0 && mes.length != 0 && anio.length != 0) {
      Load_ProductosVAnio(mes, anio, sedea);
    } else if (sedea.length != 0 && mes.length == 0 && anio.length != 0) {
      Load_ProductosVAnio(0, anio, sedea);
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
      Load_ProductosVAnio(0, 0, 0);
  }

}

function verFMarca() {
  var criterio;
  $("a[name ='filter_pv']").each(function() {
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
  $("a[name ='filter_pv']").each(function() {
    $(this).removeClass("active_nav");
  });
}

$(document).ready(function() {
  Load_ProductosV('0-0-0', 1, 0, 0, 0);
  Get_SedesSel("#fpvSedes");
  Get_SedesSel("#fpvSedesa");
  Get_AniosSel("#fpvanio");
  Get_MesesSel("#fpvmes");

})
