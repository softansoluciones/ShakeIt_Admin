<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Insumos.php');


$datos = new Insumos();
$res = new \stdClass();

if (isset($_GET["insumos"])) {

    $resultado = $datos->get_Insumos();

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

if (isset($_POST["insumo"])) {

    $entrada = $_POST["insumo"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];

    $resultado = $datos->get_Insumo($id);

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

if (isset($_POST["insumosxnom"])) {

    $entrada = $_POST["insumosxnom"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $nom = $datosparciales[0];

    $resultado = $datos->get_InsumoXNom($nom);

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

    $nom = $datosparciales[0];
    $uni = $datosparciales[1];
    $cmin = $datosparciales[2];

    $resultado = $datos->insert_Insumo($nom, $uni, $cmin);

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

    $id = $datosparciales[0];
    $nom = $datosparciales[1];
    $uni = $datosparciales[2];
    $cmin = $datosparciales[3];

    $resultado = $datos->update_Insumo($id, $nom, $uni, $cmin);

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

    $id = $datosparciales[0];

    $resultado = $datos->delete_Insumo($id);

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
