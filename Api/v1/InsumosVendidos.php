<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/InsumosVendidos.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new InsumosVendidos();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("InsumosVendidos.php/", $url);

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
    $GLOBALS['tokenhash'] = $_SERVER['HTTP_AUTHTOKEN'];
} else {
    $GLOBALS['tokenhash'] = "noauth";
}

$tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        
        switch ($metodo) {
            case 'GET':
        
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
            echo json_encode($GLOBALS['res']);

                break;
        
            case 'POST':
        
                if ($accion == "productos") {
                    SaveInsumosVendidos();
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
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
    

function SaveInsumosVendidos() {

    $data = $_POST["productos"];

        $resultado = $GLOBALS['datos']->Recorrer_Producto($data);

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

