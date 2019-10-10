<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Sedes.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Sedes();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Sedes.php/", $url);

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
            if ($accion == "lista") {
                GetSedes();
            } elseif ($accion == "id") {
                GetSedesXId($param1);
            } elseif ($accion == "nombre") {
                GetSedesXNombre();
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
            SaveSedes();
        } elseif ($accion == "actualizar") {
            UpdateSedes($param1);
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

        if ($accion == "eliminar") {
            DeleteSedes($param1);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
            echo json_encode($GLOBALS['res']);
        }

        break;

    default:
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;
}

function GetSedes() {

    $resultado = $GLOBALS['datos']->get_Sedes();

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

function GetSedesXSede($sede) {

    $resultado = $GLOBALS['datos']->get_SedesXSede($sede);

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

function GetSedesXId($id) {

    $resultado = $GLOBALS['datos']->get_Sede($id);

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

function GetSedesXNombre() {

    $nombre = $_GET['nombre_sede'];
    $resultado = $GLOBALS['datos']->get_SedeXNom($nombre);

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

function SaveSedes() {

    $nit = $_POST['nit_sede'];
    $nom = $_POST['nombre_sede'];
    $dir = $_POST['direccion_sede'];
    $mun = $_POST['municipio_sede'];
    $tel1 = $_POST['tel1_sede'];
    $tel2 = $_POST['tel2_sede'];
    $tel3 = $_POST['tel3_sede'];
    $long = $_POST['longitud_sede'];
    $lat = $_POST['latitud_sede'];

    $resultado = $GLOBALS['datos']->insert_Sede($nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

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

function UpdateSedes($id) {

    $nit = $_POST['nit_sede'];
    $nom = $_POST['nombre_sede'];
    $dir = $_POST['direccion_sede'];
    $mun = $_POST['municipio_sede'];
    $tel1 = $_POST['tel1_sede'];
    $tel2 = $_POST['tel2_sede'];
    $tel3 = $_POST['tel3_sede'];
    $long = $_POST['longitud_sede'];
    $lat = $_POST['latitud_sede'];

    $resultado = $GLOBALS['datos']->update_Sede($id, $nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

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

function DeleteSedes($id) {

    $resultado = $GLOBALS['datos']->delete_Sedes($id);

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
