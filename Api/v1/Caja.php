 <?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Caja.php');


$datos = new Caja();
$res = new \stdClass();

if (isset($_GET["caja"])) {

    $resultado = $datos->get_Caja();

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

if (isset($_POST["cajaxid"])) {

    $entrada = $_POST["cajaxid"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);
    
    $id = $datosparciales[0];

    $resultado = $datos->get_CajaXId($id);

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

if (isset($_POST["cajaxsede"])) {

    $entrada = $_POST["cajaxsede"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);
    
    $sede = $datosparciales[0];

    $resultado = $datos->get_CajaXSede($sede);

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

    $val = $datosparciales[0];
    $est = $datosparciales[1];
    $sede = $datosparciales[2];
    
    $resultado = $datos->insert_Caja($val, $est, $sede);

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
    $val = $datosparciales[1];
    $est = $datosparciales[2];
    $sede = $datosparciales[3];

    $resultado = $datos->update_Caja($id, $val, $est, $sede);

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

    $resultado = $datos->delete_Caja($id);

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

