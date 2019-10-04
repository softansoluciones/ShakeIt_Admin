<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Clientes.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Clientes();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Clientes.php/", $url);

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
                        GetClientes();
                    } elseif ($accion == "id") {
                        GetClientesXId($param1);
                    } elseif ($accion == "sede") {
                        GetClientesXSede($param1);
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
                    SaveClientes();
                } elseif ($accion == "actualizar") {
                    UpdateClientes($param1);
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
                DeleteClientes($param1);
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
    

    function GetClientes() {

        $resultado = $GLOBALS['datos']->get_Clientes($usuario);

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

function GetClientes() {

    $resultado = $GLOBALS['datos']->get_Clientes();

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

function GetClientesXId($id) {

    $resultado = $GLOBALS['datos']->get_Cliente($id);

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

function GetClientesXDoc($documento) {

    $resultado = $GLOBALS['datos']->get_ClienteXDoc($documento);

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

function GetClientesXTel($telefono) {

    $resultado = $GLOBALS['datos']->get_ClienteXTel($telefono);

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

function GetClientesXSede($sede) {

    $resultado = $GLOBALS['datos']->get_ClientesXSede($sede);

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

function SaveClientes() {

    if(isset($_POST['documento'])){
        $doc = $_POST['documento'];
    }else {
        $doc = "";
    }

    if(isset($_POST['nombres'])){
        $nom = $_POST['nombres'];
    }else {
        $nom = "";
    }

    if(isset($_POST['appellidos'])){
        $ape = $_POST['appellidos'];
    }else {
        $ape = "";
    }

    if(isset($_POST['direccion'])){
        $dir = $_POST['direccion'];
    }else {
        $dir = "";
    }

    if(isset($_POST['barrio'])){
        $barr = $_POST['barrio'];
    }else {
        $barr = "";
    }
    
    if(isset($_POST['municipio'])){
        $mun = $_POST['municipio'];
    }else {
        $mun = "";
    }

    if(isset($_POST['telefono'])){
        $tel = $_POST['telefono'];
    }else {
        $tel = "";
    }

    if(isset($_POST['usuario'])){
        $us = $_POST['usuario'];
    }else {
        $us = "";
    }

    if(isset($_POST['password'])){
        $pass = $_POST['password'];
    }else {
        $pass = "";
    }

    if(isset($_POST['email'])){
        $email = $_POST['email'];
    }else {
        $email = "";
    }

    if(isset($_POST['fecha_nacimiento'])){
        $nac = $_POST['fecha_nacimiento'];
    }else {
        $nac = "";
    }

        $resultado = $GLOBALS['datos']->insert_Cliete($doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

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

function UpdateClientes($id) {
    
    $id = $_POST['id'];
    $doc = $_POST['documento'];
    $nom = $_POST['nombres'];
    $ape = $_POST['appellidos'];
    $dir = $_POST['direccion'];
    $barr = $_POST['barrio'];
    $mun = $_POST['municipio'];
    $tel = $_POST['telefono'];
    $us = $_POST['usuario'];
    $pass = $_POST['password'];
    $email = $_POST['email'];
    $nac = $_POST['fecha_nacimiento'];

        $resultado = $GLOBALS['datos']->update_Cliente($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

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

function DeleteClientes($id) {

        $resultado = $GLOBALS['datos']->delete_Clientes($id);

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
