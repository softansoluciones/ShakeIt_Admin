/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function AgregarInsumo() {
    var num = $("#num_ins").val();
    var insid = $("#pro_ins").val();
    var nomIns = $("#pro_ins option:selected").text();
    var cantins = $("#pro_ins_cant").val();
    var unidadIns = $("#pro_ins_unidad").val();
    num++;
    //alert(num);
    $("#pro_nuevo_insumos").append('\
     <div class="form-group row" id="ins_div-' + num + '">\n\
     <div class="form-group col-md-1" style="display: none;">\n\
         <input class="form-control" type="text" id="id_inse-' + insid + '" name="ins_pdte" value="' + insid + '">\n\
     </div>\n\
     <div class="form-group col-md-4">\n\
         <input class="form-control" type="text" placeholder="Nombre De insumo" value="' + nomIns + '">\n\
     </div>\n\
     <div class="form-group col-md-4">\n\
         <input class="form-control" type="number" id="cant_insg-' + insid + '" placeholder="Cantidad" value="' + cantins + '">\n\
     </div>\n\
     <div class="form-group col-md-3">\n\
         <input class="form-control" type="text" placeholder="unidad" value="' + unidadIns + '">\n\
    </div>\n\
    <div class="form-group col-md-1">\n\
         <a href="javascript: remove_ins(' + "'#ins_div-" + num + "'" + ')"><i class="far fa-trash-alt"></i></div></a>\n\
     </div>\n\
    </div>\n\
      ');
    $("#num_ins").val(num);
    $("#pro_ins").val('');
    $("#pro_ins_cant").val('');
    $("#pro_ins_unidad").val('');
}

function remove_ins(det) {

    var num = $("#num_ins").val();
    num--;
    $(det).remove();
    $("#num_ins").val(num);
}

function ValAgregarInsumo() {

    var val = ValidarCamposAlert('ins_g')

    if (val == true) {

        validarExist();
    }

}

function validarExist() {

    var cont = 0
    var id = $("#pro_ins").val();
    $("input[name ='ins_pdte']").each(function () {

        var idpdte = $(this).val()

        if (idpdte == id) {
            cont++
        }

    })

    $("input[name ='ins_gd']").each(function () {

        var idgdo = $(this).val()

        if (idgdo == id) {
            cont++
        }

    })

    if (cont > 0) {
        $("#pro_ins").focus();
        $('#msg_alert_mod').html('<p>El insumo seleccionado ya pertenece a este producto.</p>');
        $('#msg_alert_mod').show('fast')
    } else {
        $("#pro_ins").popover('hide');
        AgregarInsumo()
    }


}

function validarGuardar() {

    var val = ValidarCamposAlert('pro_g')

    if (val == true) {
        var num = $("#num_ins").val();

        if (num > 0) {

            RecorrerInsumos(1);

        } else {

            insert_producto();

        }

    }

}

function RecorrerInsumos(val) {

    var datos = [];
    $("input[name ='ins_pdte']").each(function () {

        var idpro = $('#pro_idg').val();
        var idins = $(this).val();
        var cant = $('#cant_insg-' + idins).val();
        var items = {"pro": idpro, "ins": idins, "cant": cant};
        datos.push(items);
    });
    insert_RelacionMas(datos, val);
}

function get_idproducto(){

        id_producto();
}

$(document).ready(function () {
  $('#modal_msg').modal('hide');
    get_idproducto();
    //setInterval(get_idproducto, 1000);
    get_idproducto();
    Get_CategoriasSel('#pro_catg');
    Get_InsumosSel('#pro_ins');
});
