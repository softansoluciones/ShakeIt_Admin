<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Productos.php');


$datos = new Productos();
$res = new \stdClass();

if (isset($_GET["productos"])) {

    $resultado = $datos->get_Productos();

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

if (isset($_GET["getid"])) {

    $resultado = $datos->get_nuevoid();

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

if (isset($_POST["producto"])) {

    $entrada = $_POST["producto"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $resultado = $datos->get_Producto($datosparciales[0]);

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

if (isset($_POST["productoxcat"])) {

    $entrada = $_POST["productoxcat"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $resultado = $datos->get_ProductosXCat($datosparciales[0]);

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

    $id = $datosparciales[0];
    $nom = $datosparciales[1];
    $nomG = $datosparciales[2];
    $prec = $datosparciales[3];
    $cat = $datosparciales[4];
    $desc = $datosparciales[5];
    
    $resultado = $datos->insert_Producto($id, $nom, $nomG, $prec, $cat, $desc);

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
    $nomG = $datosparciales[2];
    $prec = $datosparciales[3];
    $cat = $datosparciales[4];
    $desc = $datosparciales[5];
   
    
    $resultado = $datos->update_Producto($id, $nom, $nomG, $prec, $cat, $desc);

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

    $resultado = $datos->delete_Producto($id);

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
