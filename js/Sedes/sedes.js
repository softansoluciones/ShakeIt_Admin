function formGuardar() {

  $("#msg_alert_modG").hide();
  $('#sede_nitg').val("");
  $('#sede_nomg').val("");
  $('#sede_dirg').val("");
  $('#sede_depg').val("");
  $('#ins_mung').val("");
  $('#sede_tel1g').val("");
  $('#sede_tel2g').val("");
  $(".is-invaid").removeClass("is-invalid");
  $('#sede_mod_guardar').modal({
    backdrop: 'static',
    keyboard: true,
    show: true
  })
}

function validarGuardar() {

  var val = ValidarCamposData('sede_g')

  if (val == true) {
    insert_sedes();
  }else{
    $("#msg_alert_modG").html(val);
    $("#msg_alert_modG").show();
  }

}

function validarActualizar() {

  var val = ValidarCamposData('sede_e')

  if (val == true) {
    update_sedes();
  }else{
    $("#msg_alert_modE").html(val);
    $("#msg_alert_modE").show();
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
  Load_Sedes();
  Get_DepartamentosSel('#sede_depg');
  Get_DepartamentosSel('#sede_depe');
  Get_MunicipiosSelAll('#sede_mune')
});
