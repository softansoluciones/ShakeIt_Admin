<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Sedes.php');


$datos = new Sedes();
$res = new \stdClass();

if (isset($_GET["sedes"])) {

    $resultado = $datos->get_Sedes();

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

if (isset($_POST["sede"])) {

    $entrada = $_POST["sede"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];

    $resultado = $datos->get_Sede($id);

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

if (isset($_POST["sedexnom"])) {

    $entrada = $_POST["sedexnom"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $nom = $datosparciales[0];

    $resultado = $datos->get_SedeXNom($nom);

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

    $nit = $datosparciales[0];
    $nom = $datosparciales[1];
    $dir = $datosparciales[2];
    $mun = $datosparciales[3];
    $tel1 = $datosparciales[4];
    $tel2 = $datosparciales[5];
    $tel3 = $datosparciales[6];
    $long = $datosparciales[7];
    $lat = $datosparciales[8];

    $resultado = $datos->insert_Sede($nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

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
    $nit = $datosparciales[1];
    $nom = $datosparciales[2];
    $dir = $datosparciales[3];
    $mun = $datosparciales[4];
    $tel1 = $datosparciales[5];
    $tel2 = $datosparciales[6];
    $tel3 = $datosparciales[7];
    $long = $datosparciales[8];
    $lat = $datosparciales[9];


    $resultado = $datos->update_Sede($id, $nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

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

    $resultado = $datos->delete_Sede($id);

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
