<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['datos'] = new Tokens();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Tokens.php/", $url);

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

switch ($metodo) {
    case 'GET':

        if ($accion != null) {
            if ($accion == "token") {
                GetTokens($param1);
            } elseif ($accion == "estado") {
                GetTokenEstado();
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

    $GLOBALS['res']->Respuesta = 0;
    $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
    echo json_encode($GLOBALS['res']);
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

function GetTokens($user) {

    $resultado = $GLOBALS['datos']->get_UserData($user);

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

function GetTokenEstado($token) {

    //$token = $_SERVER['HTTP_AUTHTOKEN'];
    $resultado = $GLOBALS['datos']->get_TokenEstado($token);

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