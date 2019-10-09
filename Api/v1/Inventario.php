<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Inventario.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Inventario();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Inventario.php/", $url);

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
                GetInventario();
            } elseif ($accion == "sede") {
                GetInventarioXSede($param1);
            } elseif ($accion == "id") {
                GetInventarioXId($param1);
            } elseif ($accion == "iden") {
                GetInventarioIden($param1);
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
            SaveInventario();
        } elseif ($accion == "guardarMas") {
            SaveInventarioMas();
        } elseif ($accion == "guardarDia") {
            SaveInventarioDia();
        } elseif ($accion == "guardarIden") {
            SaveInventarioIden();
        } elseif ($accion == "guardarProducto") {
            SaveInventarioProductos();
        } elseif ($accion == "actualizar") {
            UpdateInventario($param1);
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
            DeleteInventario($param1);
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

function GetInventario() {

    $resultado = $GLOBALS['datos']->get_Inventario();

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

function GetInventarioXSede($sede) {

    $resultado = $GLOBALS['datos']->get_InventarioXSede($sede);

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

function GetInventarioXId($id) {

    $resultado = $GLOBALS['datos']->get_InventarioOne($id);

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

function GetInventarioIden($id) {

    $resultado = $GLOBALS['datos']->get_InventarioIden($id);

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

function SaveInventario() {

    $ins = $_POST['id_insumo'];
    $cant = $_POST['cantidad_insumo'];
    $sed = $_POST['sede_insumo'];

    $resultado = $GLOBALS['datos']->insert_Inventario($ins, $cant, $sed);
    ;

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

function SaveInventarioMas() {

    $data = $_POST["imsumos_obj"];

    $resultado = $GLOBALS['datos']->insert_InventarioMas($data);

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

function SaveInventarioDia() {

    $ins = $_POST['id_insumo'];
    $cant = $_POST['cantidad_insumo'];
    $sed = $_POST['sede_insumo'];

    $resultado = $GLOBALS['datos']->insert_InventarioDia($ins, $cant, $sed);

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

function SaveInventarioIden() {

    $iden = $_POST['identificador'];
    $est = $_POST['estado_identificador'];
    $sed = $_POST['sede_identificador'];

    $resultado = $GLOBALS['datos']->insert_InventarioIden($iden, $est, $sed);

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

function SaveInventarioProductos() {

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

function UpdateInventario($id) {

    $ins = $_POST['id_insumo'];
    $cant = $_POST['cantidad_insumo'];
    $sed = $_POST['sede_insumo'];

    $resultado = $GLOBALS['datos']->update_Inventario($id, $ins, $cant, $sed);

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

function DeleteInventario($id) {

    $resultado = $GLOBALS['datos']->delete_Inventario($id);

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
