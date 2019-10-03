function formGuardar() {

  $("#msg_alert_mod").hide();
  $("#ins_nomg").val("");
  $("#ins_nomg").removeClass("is-invalid");
  $("#ins_cantg").val("");
  $("#ins_cantg").removeClass("is-invalid");
  $("#ins_unig").val("");
  $("#ins_unig").removeClass("is-invalid");
  $('#ins_mod_guardar').modal({
    backdrop: 'static',
    keyboard: true,
    show: true
  })

}

function validarGuardar() {

  var val = ValidarCamposAlert('ins_g')

  if (val == true) {

    insert_insumos();

  }

}

function validarActualizar() {

  var val = ValidarCamposAlert('ins_e')

  if (val == true) {

    update_insumos()

  }

}

function confirmarEliminar(id) {

  $("#msg").html("<center><p>¿Realmente desea eliinar este insumo?</p></center>");
  $("#btns").html('<a class="btn btn-danger" data-dismiss="modal" aria-label="Close" href="#" role="button">Cancelar</a>\n\
                     <a class="btn btn_sh_normal" href="javascript: delete_insumos(' + id + ')" role="button">Aceptar</a>');
  $("#modal_msg").modal({
    backdrop: 'static',
    keyboard: true,
    show: true
  });

}

$(document).ready(function() {
  Load_Insumos();
  Get_UnidadesSel('#ins_unie');
  Get_UnidadesSel('#ins_unig');
});
