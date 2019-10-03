<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Clientes.php');


$datos = new Clientes();
$res = new \stdClass();

if (isset($_GET["clientes"])) {

    $resultado = $datos->get_Clientes();

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

if (isset($_POST["cliente"])) {

    $entrada = $_POST["cliente"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);
    
    $id = $datosparciales[0];

    $resultado = $datos->get_Cliente($id);

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

if (isset($_POST["clientedoc"])) {

    $entrada = $_POST["clientedoc"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);
    
    $doc = $datosparciales[0];

    $resultado = $datos->get_ClienteXDoc($doc);

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

if (isset($_POST["clientetel"])) {

    $entrada = $_POST["clientetel"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);
    
    $tel = $datosparciales[0];

    $resultado = $datos->get_ClienteXTel($tel);

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

    $doc = $datosparciales[0];
    $nom = $datosparciales[1];
    $ape = $datosparciales[2];
    $dir = $datosparciales[3];
    $barr = $datosparciales[4];
    $mun = $datosparciales[5];
    $tel = $datosparciales[6];
    $us = $datosparciales[7];
    $pass = $datosparciales[8];
    $email = $datosparciales[9];
    $nac = $datosparciales[10];

    $resultado = $datos->insert_Cliete($doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

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

if (isset($_POST["insertarlocal"])) {

    $entrada = $_POST["insertarlocal"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $doc = $datosparciales[0];
    $nom = $datosparciales[1];
    $ape = $datosparciales[2];
    $dir = $datosparciales[3];
    $barr = $datosparciales[4];
    $mun = $datosparciales[5];
    $tel = $datosparciales[6];
    $email = $datosparciales[7];
    $nac = $datosparciales[8];

    $resultado = $datos->insert_ClieteLocal($doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac);

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

if (isset($_POST["insertarventa"])) {

    $entrada = $_POST["insertarventa"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $nom = $datosparciales[0];
    $ape = $datosparciales[1];
    $dir = $datosparciales[2];
    $barr = $datosparciales[3];
    $mun = $datosparciales[4];
    $tel = $datosparciales[5];

    $resultado = $datos->insert_ClieteVenta($nom, $ape, $dir, $barr, $mun, $tel);

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
    $doc = $datosparciales[1];
    $nom = $datosparciales[2];
    $ape = $datosparciales[3];
    $dir = $datosparciales[4];
    $barr = $datosparciales[5];
    $mun = $datosparciales[6];
    $tel = $datosparciales[7];
    $us = $datosparciales[8];
    $pass = $datosparciales[9];
    $email = $datosparciales[10];
    $nac = $datosparciales[11];

    $resultado = $datos->update_Cliente($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

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

if (isset($_POST["actualizarlocal"])) {

    $entrada = $_POST["actualizarlocal"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];
    $doc = $datosparciales[1];
    $nom = $datosparciales[2];
    $ape = $datosparciales[3];
    $dir = $datosparciales[4];
    $barr = $datosparciales[5];
    $mun = $datosparciales[6];
    $tel = $datosparciales[7];
    $email = $datosparciales[8];
    $nac = $datosparciales[9];

    $resultado = $datos->update_ClienteLocal($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac);

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

if (isset($_POST["actualizarventa"])) {

    $entrada = $_POST["actualizarventa"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $id = $datosparciales[0];
    $nom = $datosparciales[1];
    $ape = $datosparciales[2];
    $dir = $datosparciales[3];
    $barr = $datosparciales[4];
    $mun = $datosparciales[5];
    $tel = $datosparciales[6];
    
    $resultado = $datos->update_ClienteVenta($id, $nom, $ape, $dir, $barr, $mun, $tel);

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

