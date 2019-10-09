<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Alertas.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Alertas();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Alertas.php/", $url);

if (count($urlservicios) > 1) {
    $urlserviciosdes = explode("?", $urlservicios[1]);
    $urlserviciosget = explode("/", $urlservicios[1]);
    if (count($urlserviciosdes) > 1) {
        $accion = $urlserviciosdes[0];
    } else {
        $accion = $urlserviciosget[0];
    }
    if (count($urlserviciosget) > 1) {
        $param1 = $urlserviciosget[1];
        if (count($urlserviciosget) > 2) {
            $param2 = $urlserviciosget[2];
        }
    }
}

$metodo = $_SERVER['REQUEST_METHOD'];

if (isset($_SERVER['HTTP_AUTHTOKEN'])) {
    $token_ = $_SERVER['HTTP_AUTHTOKEN'];
} else {
    $token_ = "noauth";
}

$GLOBALS['token']->tokenV($token_);

switch ($metodo) {
    case 'GET':

        if ($accion != null) {
            if ($accion == "alertas") {
                GetAlertas($param1);
            } elseif ($accion == "id") {
                GetAlertaXId($param1);
            } elseif ($accion == "cantidad") {
                GetAlertasCantidad($param1);
            } else {
                $GLOBALS['res']->Respuesta = 0;
                $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
                echo json_encode($GLOBALS['res']);
            }
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No se ha detectado acción";
            echo json_encode($GLOBALS['res']);
        }
        break;

    case 'POST':

        if ($accion == "guardar") {
            SaveAlerta();
        } elseif ($accion == "actualizar") {
            UpdateAlerta($param1);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
            echo json_encode($GLOBALS['res']);
        }
        break;

    case 'PUT':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);

        break;

    case 'DELETE':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);

        break;

    default:
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;
}

function GetAlertas($usuario) {

    $resultado = $GLOBALS['datos']->get_Alertas($usuario);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetAlertaXId($id) {

    $resultado = $GLOBALS['datos']->get_Alerta($id);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetAlertasCantidad($usuario) {

    $resultado = $GLOBALS['datos']->get_AlertasCant($usuario);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
}

function SaveAlerta() {

    $nom = $_POST['nombre'];
    $des = $_POST['descripcion'];
    $us = $_POST['usuarios'];

    $resultado = $GLOBALS['datos']->insert_Alertas($nom, $des, $us);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información registrada con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Error al registrar información.";
        echo json_encode($GLOBALS['res']);
    }
}

function UpdateAlerta($id) {

    $resultado = $GLOBALS['datos']->update_Alertas($id);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información registrada con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Error al registrar información.";
        echo json_encode($GLOBALS['res']);
    }
}

function DeleteAlerta($id) {

    $resultado = $GLOBALS['datos']->delete_Alertas($id);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información eliminada con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Error al eliminar información.";
        echo json_encode($GLOBALS['res']);
    }
}
