<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/RelacionInsumos.php');


$datos = new RelacionInsumos();
$res = new \stdClass();

if (isset($_GET["relaciones"])) {

    $resultado = $datos->get_Relaciones();

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_POST["relacionxprod"])) {

    $entrada = $_POST["relacionxprod"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $resultado = $datos->get_RelacionXPro($datosparciales[0]);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_POST["insertar"])) {

    $entrada = $_POST["insertar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $pro = $datosparciales[0];
    $ins = $datosparciales[1];
    $cant = $datosparciales[2];


    $resultado = $datos->insert_Relacion($pro, $ins, $cant);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Se ha registrado la información con éxito.";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "Error al actualizar la información.";
        echo json_encode($res);
    }
}

if (isset($_POST["insertarmas"])) {

    $data = $_POST["insertarmas"];

    $resultado = $datos->insert_RelacionMas($data);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Se ha registrado la información con éxito.";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "Error al registrar la información.";
        echo json_encode($res);
    }
}

if (isset($_POST["actualizar"])) {

    $entrada = $_POST["actualizar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);


    $pro = $datosparciales[0];
    $ins = $datosparciales[1];
    $cant = $datosparciales[2];


    $resultado = $datos->update_Relacion($pro, $ins, $cant);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Se ha actualizado la información con éxito.";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "Error al actualizar la información.";
        echo json_encode($res);
    }
}

if (isset($_POST["eliminar"])) {

    $entrada = $_POST["eliminar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $pro = $datosparciales[0];
    $ins = $datosparciales[1];

    $resultado = $datos->delete_Relacion($pro, $ins);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Se han eliminado los datos.";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "Error al eliminar información.";
        echo json_encode($res);
    }
}
