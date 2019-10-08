<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Ventas.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Ventas();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Auxiliar.php/", $url);

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
        
                if ($accion != null) {
                    if ($accion == "lista") {
                        GetVentas();
                    } elseif ($accion == "id") {
                        GetVentasXId($param1);
                    }elseif ($accion == "detalle") {
                        GetDetalleVenta($param1);
                    } elseif ($accion == "filtros") {
                        GetVentasFiltros();
                    }else {
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
                    SaveVentas();
                }else {
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
                DeleteVentas($param1);
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
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
    

function GetVentas() {

        $fecha = $_GET['fecha'];
        $dia =   $_GET['dia'];
        $mes =   $_GET['mes'];
        $anio =  $_GET['anio'];
        $sede =  $_GET['sede'];

        $resultado = $GLOBALS['datos']->get_Ventas($fecha, $dia, $mes, $anio, $sede);
        $total = $GLOBALS['datos']->get_VentasTotal($fecha, $dia, $mes, $anio, $sede);

        if ($resultado != 0) {

            $GLOBALS['res']->Data = $resultado;
            $GLOBALS['res']->Total = $total;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
}

function GetVentasFiltros() {

    $mes = $_GET['mes'];
    $anio = $_GET['anio'];
    $sede = $_GET['sede'];

    $resultado = $GLOBALS['datos']->get_VentasFilt($mes, $anio, $sede);
    $total = $GLOBALS['datos']->get_VentasFiltTotal($mes, $anio, $sede);

    if ($resultado != 0) {

        $GLOBALS['res']->Data = $resultado;
        $GLOBALS['res']->Total = $total;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetVentasXId($id) {

    $resultado = $GLOBALS['datos']->get_Venta($id); 

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

function GetDetalleVenta($id) {

    $resultado = $GLOBALS['datos']->get_Detalle($id);

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

function SaveVentas() {

    $cant = $_GET['cantidad'];
    $fac =     $_GET['factura'];
    $sede =    $_GET['sede'];
    $consumo = $_GET['consumo'];
    $pago =    $_GET['pago'];
    $ent =     $_GET['entidad'];
    $val =     $_GET['valor'];

        $resultado = $GLOBALS['datos']->insert_Venta($cant, $fac, $sede, $consumo, $pago, $ent, $val);

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

function UpdateVentas($id) {
    
    $doc = $_POST['documento_usuario'];
    $nom = $_POST['nombres_usuario'];
    $ape = $_POST['apellidos_usuario'];
    $tel = $_POST['telefono_usuario'];
    $email =$_POST['email_usuario'];
    $pass = $_POST['password_usuario'];
    $tipo = $_POST['tipo_usuario'];
    $estado = $_POST['estado_usuario'];

        $resultado = $GLOBALS['datos']->update_Usuario($id, $doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

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

function DeleteVentas($id) {

        $resultado = $GLOBALS['datos']->delete_Usuario($id);

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
