var fecha = new Date();
var anio = fecha.getYear() - 100;
var mes = fecha.getMonth() + 1;
var dia = fecha.getDate();
var base = 'http://localhost/';
var baseRem = 'https://shakeitcol.co/';

function buscarD(tabla) {
    var tableReg = document.getElementById(tabla);
    var searchText = document.getElementById('filtrar').value.toLowerCase();
    var cellsOfRow = "";
    var found = false;
    var compareWith = "";

    // Recorremos todas las filas con contenido de la tabla
    for (var i = 1; i < tableReg.rows.length; i++) {
        cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
        found = false;
        // Recorremos todas las celdas
        for (var j = 0; j < cellsOfRow.length && !found; j++) {
            compareWith = cellsOfRow[j].innerHTML.toLowerCase();
            // Buscamos el texto en el contenido de la celda
            if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                found = true;
            }
        }
        if (found) {
            tableReg.rows[i].style.display = '';
        } else {
            // si no ha encontrado ninguna coincidencia, esconde la
            // fila de la tabla
            tableReg.rows[i].style.display = 'none';
        }
    }
}

function ValidarCampos(name) {

    var tot = countCampos(name);
    var cont = 0;
    $("input[name ='" + name + "'], select[name ='" + name + "'], textarea[name ='" + name + "']").each(function () {
        if ($(this).val().length == 0) {
            var camp = $(this).attr("campo");

            $.notify("<p>Es necesario llenar el campo " + camp + "</p>", {
                animate: {
                    enter: 'animated fadeInRight',
                    exit: 'animated fadeOutRight',
                    position: 'absolute'
                }
            });

            $(this).addClass("is-invalid");
            $(this).focus();
            //$("#amsg").focus();
            return false;
        }
        cont++;
    });
    if (cont == tot) {
        return true;
    }

}

function ValidarCamposAlert(name) {

    var tot = countCampos(name);
    var cont = 0;
    $("input[name ='" + name + "'], select[name ='" + name + "'], textarea[name ='" + name + "']").each(function () {
        if ($(this).val().length == 0) {
            var camp = $(this).attr("campo");

            $('#msg_alert_mod').html('<p>Es necesario que llene el campo ' + camp + '</p>');
            $('#msg_alert_mod').show('fast')

            $(this).addClass("is-invalid");
            $(this).focus();
            //$("#amsg").focus();
            return false;
        }
        cont++;
    });
    if (cont == tot) {
        return true;
    }

}

function ValidarCamposAlertGuardar(name) {

    var tot = countCampos(name);
    var cont = 0;
    $("input[name ='" + name + "'], select[name ='" + name + "'], textarea[name ='" + name + "']").each(function () {
        if ($(this).val().length == 0) {
            var camp = $(this).attr("campo");

            $('#msg_alert_modG').html('<p>Es necesario que llene el campo ' + camp + '</p>');
            $('#msg_alert_modG').show('fast')

            $(this).addClass("is-invalid");
            $(this).focus();
            //$("#amsg").focus();
            return false;
        }
        cont++;
    });
    if (cont == tot) {
        return true;
    }

}

function ValidarCamposData(name) {

    var tot = countCampos(name);
    var cont = 0;
    var msg;
    $("input[name ='" + name + "'], select[name ='" + name + "'], textarea[name ='" + name + "']").each(function () {
        if ($(this).val().length == 0) {
            var camp = $(this).data("campo");

            msg = '<p>Es necesario que llene el campo ' + camp + '</p>';

            $(this).addClass("is-invalid");
            $(this).focus();
            return false;
        }
        cont++;
    });
    if (cont == tot) {
        return true;
    } else {
        return msg;
    }

}

function countCampos(name) {
    var cont = 0;
    $("input[name ='" + name + "'], select[name ='" + name + "'], textarea[name ='" + name + "']").each(function () {
        cont++;
    });

    return cont;
}

function removec(d) {

    $('#msg_alert_modG').hide('fast');
    $('#msg_alert_modE').hide('fast');
    $('#msg_alert_mod').hide('fast');
    $('.alert').hide('fast');
    $(d).removeClass("is-invalid");
}

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

function Get_UsuarioMod() {

    var userlid = parseInt(sessionStorage.getItem("id_user"))

    var dataserver = userlid + '|' + "Dato"
    var dataserverb = window.btoa(dataserver);
    var usuario = {
        "usuarioxid": dataserverb
    };

    $.ajax({
        type: 'GET',
        url: 'Api/Servicios/Usuarios.php',
        data: usuario,
        dataType: 'json',
        success: function (response) {
            if (response.Respuesta != 0) {
                //debugger
                if (response.Respuesta[0].estado_usuario == 2) {
                    LogOut();
                } else if (response.Respuesta[0].tipo_usuario == 1) {
                    LogOut();
                } else {
                    var idus = response.Respuesta[0].id_usuario;
                    var nomus = response.Respuesta[0].nom_usuario;
                    var apeus = response.Respuesta[0].ape_usuario;
                    var tipus = response.Respuesta[0].tipo_usuario;
                    var nomtipus = response.Respuesta[0].nom_tipo;
                    sesionUs(idus, nomus, apeus, tipus, nomtipus)
                }
            } else {
                LogOut();
            }
        },
        beforeSend: function () {

        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        $('#user_mod_editar').modal('hide')
        $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn-primary m-r-1em' value='Aceptar'/>");
        $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
        $("#modal_msg").modal({ backdrop: 'static', keyboard: true, show: true });
    });

}

function sesionUs(idus, nomus, apeus, tipus, nomtipus) {
    sessionStorage.setItem("ses_estado", "ShakeItAdmin");
    sessionStorage.setItem("id_user", idus);
    localStorage.setItem("id_user", idus);
    sessionStorage.setItem("nom_user", nomus + " " + apeus);
    sessionStorage.setItem("tipo_user", tipus);
    sessionStorage.setItem("nomtipo_user", nomtipus);
}
