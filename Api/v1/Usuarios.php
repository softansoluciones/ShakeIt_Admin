<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Usuarios.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Usuarios();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Usuarios.php/", $url);

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


switch ($metodo) {
    case 'GET':

        if ($accion != null) {
            if ($accion == "lista") {
                $GLOBALS['token']->tokenV($token_);
                GetUsuarios();
            } elseif ($accion == "id") {
                $GLOBALS['token']->tokenV($token_);
                GetUsuariosXId($param1);
            } elseif ($accion == "documento") {
                $GLOBALS['token']->tokenV($token_);
                GetUsuariosXDocumento($param1);
            } elseif ($accion == "nombre") {
                $GLOBALS['token']->tokenV($token_);
                GetUsuariosXNombre();
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
            SaveUsuarios();
        } elseif ($accion == "actualizar") {
            $GLOBALS['token']->tokenV($token_);
            UpdateUsuarios($param1);
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
            DeleteUsuarios($param1);
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

function GetUsuarios() {

    $resultado = $GLOBALS['datos']->get_Usuarios();

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

function GetUsuariosXUsuario($Usuario) {

    $resultado = $GLOBALS['datos']->get_UsuariosXUsuario($Usuario);

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

function GetUsuariosXId($id) {

    $resultado = $GLOBALS['datos']->get_Usuario($id);

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

function GetUsuariosXDocumento($documento) {

    $resultado = $GLOBALS['datos']->get_UsuarioXDoc($documento);

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

function LoginUsuario() {

    $doc = $_POST['documento_usuario'];
    $pass = $_POST['password_usuario'];

    $resultado = $GLOBALS['datos']->get_UsuarioLogin($doc, $pass);

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

function SaveUsuarios() {

    $doc = $_POST['documento_usuario'];
    $nom = $_POST['nombres_usuario'];
    $ape = $_POST['apellidos_usuario'];
    $tel = $_POST['telefono_usuario'];
    $email = $_POST['email_usuario'];
    $pass = $_POST['password_usuario'];
    $tipo = $_POST['tipo_usuario'];
    $estado = $_POST['estado_usuario'];

    $resultado = $GLOBALS['datos']->insert_Usuario($doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

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

function UpdateUsuarios($id) {

    $doc = $_POST['documento_usuario'];
    $nom = $_POST['nombres_usuario'];
    $ape = $_POST['apellidos_usuario'];
    $tel = $_POST['telefono_usuario'];
    $email = $_POST['email_usuario'];
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

function DeleteUsuarios($id) {

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
