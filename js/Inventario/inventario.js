/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validarGuardar() {

    var val = ValidarCamposAlertGuardar('inv_g')

    if (val == true) {

        insert_inventario();

    }

}

function validarActualizar() {

    var val = ValidarCamposAlert('inv_e')

    if (val == true) {

        update_inventario();

    }

}

function confirmarEliminar(id) {

    $("#msg").html("<center><p>¿Realmente desea eliminar este insumo?</p></center>");
    $("#btns").html('<a class="btn btn-danger" data-dismiss="modal" aria-label="Close" href="#" role="button">Cancelar</a>\n\
                     <a class="btn btn-primary" href="javascript: delete_inventario(' + id + ')" role="button">Aceptar</a>');
    $("#modal_msg").modal({backdrop: 'static', keyboard: true, show: true});
}

function formGuardar(){

    $("#inv_ins").val("");
    $("#inv_cant").val("");
    $("#inv_unidad").val("");
Load_Sedes()
    $('#inv_mod_guardar').modal({backdrop: 'static', keyboard: true, show: true})

}

function RecorrerSedes() {

    var datos = [];

    $("input[name='sedCheck']:checked").each(function () {

        var ins = $("#inv_ins").val();
        var cant = $("#inv_cant").val();
        var sede = $(this).data("id")

        var items = {"ins": ins, "cant": cant, "sede": sede};
        datos.push(items);
    });
    return datos;
}

$(document).ready(function () {
    Load_Inventario();
    Get_InsumosSel("#inv_ins");
    Get_InsumosSel("#inv_inse");
});
