<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Usuarios.php');


$datos = new Usuarios();
$res = new \stdClass();

if (isset($_POST["login"])) {

    $entrada = $_POST["login"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

        $resultado = $datos->get_UsuarioLogin($datosparciales[0], $datosparciales[1]);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Ok";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "Error de autenticación.";
            echo json_encode($res);
        }

}

if (isset($_GET["usuarios"])) {

    $entrada = $_GET["usuarios"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

        $resultado = $datos->get_usuarios();

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Ok";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "No existe inforación.";
            echo json_encode($res);
        }
}

if (isset($_GET["usuarioxid"])) {

    $entrada = $_GET["usuarioxid"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

        $resultado = $datos->get_Usuario($datosparciales[0]);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Ok";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "No existe inforación.";
            echo json_encode($res);
        }
}

if (isset($_GET["usuarioxdoc"])) {

    $entrada = $_GET["usuarioxdoc"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

        $resultado = $datos->get_UsuarioXDoc($datosparciales[0]);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Ok";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "No existe inforación.";
            echo json_encode($res);
        }
}

if (isset($_POST["insertar"])) {

    $entrada = $_POST["insertar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

$doc = $datosparciales[0];
$nom = $datosparciales[1];
$ape = $datosparciales[2];
$tel = $datosparciales[3];
$email = $datosparciales[4];
$pass = $datosparciales[5];
$tipo = $datosparciales[6];
$estado = $datosparciales[7];

        $resultado = $datos->insert_Usuario($doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "información registrada con éxito.";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "Error al guardar la información.";
            echo json_encode($res);
        }
}

if (isset($_POST["actualizar"])) {

    $entrada = $_POST["actualizar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

$id = $datosparciales[0];
$doc = $datosparciales[1];
$nom = $datosparciales[2];
$ape = $datosparciales[3];
$tel = $datosparciales[4];
$email = $datosparciales[5];
$pass = $datosparciales[6];
$tipo = $datosparciales[7];
$estado = $datosparciales[8];

        $resultado = $datos->update_Usuario($id, $doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Se ha guardado información con éxito";
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

        $resultado = $datos->delete_Usuario($id);

        if ($resultado != 0) {
            $res->Respuesta = $resultado;
            $res->Mensaje = "Se ha eliminado información con éxito.";
            echo json_encode($res);
        } else {
            $res->Respuesta = 0;
            $res->Mensaje = "Error al eliminar la información.";
            echo json_encode($res);
        }
}
