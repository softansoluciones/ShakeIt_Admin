function formGuardar() {

        $('#us_docg').val("");
        $('#us_nomg').val("");
        $('#us_apeg').val("");
        $('#us_telg').val("");
        $('#us_emailg').val("");
        $('#us_tipog').val("");

        $("#msg_alert_modG").hide();
        $(".is-invalid").removeClass("is-invalid")
        $('#user_mod_guardar').modal({
            backdrop: 'static',
            keyboard: true,
            show: true
        })
    }

    function validaDatos(accion) {

        if (accion == "G") {

            var tel = $('#us_telg').val().length;
            var email = $('#us_emailg').val();

        }

        if (accion == "A") {

            var tel = $('#us_tele').val().length;
            var email = $('#us_emaile').val();

        }

var formatoEmail = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i

        if (tel >= 10) {
            if (formatoEmail.test(email)) {
                return true
            } else {
                return "El correo electrónico no es válido.";
            }
        } else {
            return "El número de teléfono debe contener 10 caracteres o más.";
        }


    }



    function validarGuardar() {

        var data = validaDatos("G")
        var val = ValidarCamposData('us_g')

        if (val == true) {
            if (data == true) {
                insert_Usuarios();
            } else {
                $("#msg_alert_modG").html(data)
                $("#msg_alert_modG").show("fast")
            }
        } else {
            $("#msg_alert_modG").html(val)
            $("#msg_alert_modG").show("fast")
        }

    }

    function reiniciarPassword() {

        var doc = $("#us_doce").val();
        $("#us_passe").val(doc);
        $("#usResetPass").addClass("disabled");

    }

    function validarActualizar() {

        var data = validaDatos("A")
        var val = ValidarCamposData('us_e')

        if (val == true) {
            if (data == true) {
                update_Usuarios();
            } else {
                $("#msg_alert_modE").html(data)
                $("#msg_alert_modE").show("fast")
            }
        } else {
            $("#msg_alert_modE").html(val)
            $("#msg_alert_modE").show("fast")
        }

    }

    function confirmarEliminar(id) {

        $("#msg").html("<center><p>¿Realmente desea eliminar este usuario?</p></center>");
        $("#btns").html('<a class="btn btn-danger" data-dismiss="modal" aria-label="Close" href="#" role="button">Cancelar</a>\n\
                     <a class="btn btn_sh_normal" href="javascript: delete_Usuarios(' + id + ')" role="button">Aceptar</a>');
        $("#modal_msg").modal({
            backdrop: 'static',
            keyboard: true,
            show: true
        });
    }

    $(document).ready(function () {
        Load_Usuarios();
        Get_UsuarioTipoSel('#us_tipog');
        Get_UsuarioTipoSel('#us_tipoe');
        Get_EstadosSel('#us_estadoe')
    });
