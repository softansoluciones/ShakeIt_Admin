<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Parametrizador.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Parametrizador();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Parametrizador.php/", $url);

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
                GetParametrizador();
            } elseif ($accion == "categorias") {
                GetCategorias();
            }elseif ($accion == "categoriasp") {
                GetCategoriasP();
            } elseif ($accion == "categoriass") {                
                GetCategoriasS();
            } elseif ($accion == "consumo") {
                GetConsumo();
            }elseif ($accion == "entidades") {
                GetEntidades();
            }elseif ($accion == "medios") {
                get();
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
            $GLOBALS['token']->tokenV($token_);
            SaveParametrizador();
        } elseif ($accion == "actualizar") {
            $GLOBALS['token']->tokenV($token_);
            UpdateParametrizador($param1);
        } elseif ($accion == "login") {
            LoginUsuario();
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
            $GLOBALS['token']->tokenV($token_);
            DeleteParametrizador($param1);
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

function GetParametrizador() {

    $resultado = $GLOBALS['datos']->get_Parametrizador();

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

//Categorias

function GetCategorias() {

    $resultado = $GLOBALS['datos']->get_Categorias();

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

function GetCategoriasP() {

    $resultado = $GLOBALS['datos']->get_CategoriasPrincipales();

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

function GetCategoriasS() {

    $resultado = $GLOBALS['datos']->get_CategoriasScundarias();

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

function SaveCategorias() {

    $nombre = $_POST['nombre'];
    $tipo = $_POST['tipo_categoria'];

    $resultado = $GLOBALS['datos']->insert_Categoria($nombre, $tipo);

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

function update_Categoria($id) {

     $nombre = $_POST['nombre'];
    $tipo = $_POST['tipo_categoria'];

    $resultado = $GLOBALS['datos']->update_Categoria($id, $nombre, $tipo);

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

//Consumo
function GetConsumo() {

    $resultado = $GLOBALS['datos']->get_Consumo();

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

function SaveConsumo() {

    $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->insert_Consumo($nombre);

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

function UpdateConsumo($id) {

     $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->update_Categoria($id, $nombre);

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

//Entidades de pago
function GetEntidades() {

    $resultado = $GLOBALS['datos']->get_Entidades();

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

function SaveEntidades() {

    $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->insert_Entidades($nombre);

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

function UpdateEntidades($id) {

     $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->update_Entidades($id, $nombre);

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

//Medios de pago
function GetMedioPago() {

    $resultado = $GLOBALS['datos']->get_MedioPago();

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

function SaveMedioPago() {

    $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->insert_MedioPago($nombre);

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

function UpdateMedioPago($id) {

     $nombre = $_POST['nombre'];

    $resultado = $GLOBALS['datos']->update_MedioPago($id, $nombre);

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

//Unidades
function GetUnidades() {

    $resultado = $GLOBALS['datos']->get_Unidades();

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

function SaveUnidades() {

    $nombre = $_POST['nombre'];
    $simbolo = $_POST['simbolo'];

    $resultado = $GLOBALS['datos']->insert_Unidades($nombre, $simbolo);

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

function UpdateUnidades($id) {

     $nombre = $_POST['nombre'];
     $simbolo = $_POST['simbolo'];

    $resultado = $GLOBALS['datos']->update_Unidades($id, $nombre, $simbolo);

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