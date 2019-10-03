<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Inventario.php');


$datos = new Inventario();
$res = new \stdClass();

if (isset($_GET["inventario"])) {

    $resultado = $datos->get_Inventario();

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

if (isset($_GET["inventarioxsede"])) {

    $entrada = $_POST["inventarioxsede"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];

    $resultado = $datos->get_InventarioXSede($id);

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

if (isset($_POST["inventarioxid"])) {

    $entrada = $_POST["inventarioxid"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];

    $resultado = $datos->get_InventarioOne($id);

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

if (isset($_POST["inventarioiden"])) {

    $entrada = $_POST["inventarioiden"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];

    $resultado = $datos->get_InventarioIden($id);

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

    $ins = $datosparciales[0];
    $cant = $datosparciales[1];
    $sed = $datosparciales[2];

    $resultado = $datos->insert_Inventario($ins, $cant, $sed);

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

if (isset($_POST["insertarmas"])) {

    $data = $_POST["insertarmas"];

    $resultado = $datos->insert_InventarioMas($data);

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

if (isset($_POST["insertardia"])) {

    $entrada = $_POST["insertardia"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $ins = $datosparciales[0];
    $cant = $datosparciales[1];
    $iden = $datosparciales[2];

    $resultado = $datos->insert_InventarioDia($ins, $cant, $iden);

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

if (isset($_POST["insertariden"])) {

    $entrada = $_POST["insertariden"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $iden = $datosparciales[0];
    $est = $datosparciales[1];
    $sed = $datosparciales[2];

    $resultado = $datos->insert_InventarioIden($iden, $est, $sed);

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

if (isset($_POST["productos"])) {

    $data = $_POST["productos"];

    $resultado = $datos->Recorrer_Producto($data);

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
    $ins = $datosparciales[1];
    $cant = $datosparciales[2];
    $sed = $datosparciales[3];

    $resultado = $datos->update_Inventario($id, $ins, $cant, $sed);

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

    $resultado = $datos->delete_Inventario($id);

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
